let fn ds =
    let d = Seq.length ds
    Seq.cache <| seq {
        for i in 0 .. (d-1) ->
            [1; 0; -1; 0]
            |> Seq.map(Seq.replicate(i + 1))
            |> Seq.concat
            |> Seq.replicate(int(ceil(float(d - i) / 3.0)))
            |> Seq.concat
            |> Seq.append(Seq.replicate i 0)
            |> Seq.take(d)
            |> Seq.zip(ds)
            |> Seq.map(fun (l, r) -> l * r)
            |> Seq.sum
            |> (fun s -> abs s % 10)
    }

[<EntryPoint>]
let main argv =
    let input =
        System.IO.File.ReadAllText("input.txt").ToCharArray()
        |> Array.map(fun c -> int c - 48)
        |> Array.toSeq
        |> Seq.cache

    let res =
        let rec loop = function
            | 100, v -> v |> Seq.map(string) |> String.concat("")
            | i,   v -> loop((i + 1), fn v)

        loop(0, input)

    printfn "%s" res.[0..7]
    
    0
