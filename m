Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D75344D94
	for <linux-mmc@vger.kernel.org>; Thu, 22 Jan 2026 18:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769105047; cv=pass; b=PjORPyIZwwM0qZgJHvilKJipabA2hrsy8HUFaAUFsaZFV4Y2HF84tI6b+CKgdFHNA9rY2YIr0NJQc0wvyiWU7rjlp2dVwcNn8MDH+hm5yOiBcD0fODhsmT0n15dMh8oOtiHDIRqIFbFkIuBNnoLqZz4qpCOk2IKPy2pj7SneuVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769105047; c=relaxed/simple;
	bh=s5lqreTT0Td3LlZdo0MIlSh7gzU6l3iITxUuJdreHNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JMaJEJJG9ApX06nBtxNeQg8y8P6Wt6HtYp91jrqT5OCw6vpKIR1FtFWgNBKZIstVnpnLvcXJl78KrrVj/zIKE1Uri6VfnRebgzQTlamkgXyfC2wksKwWId31zQFZucy1YQUqydQj5RlXoFzMKYePIya+fAx1aOut8cVPT/4Dsg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YQnd3lv8; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YQnd3lv8"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-59de2d1fc2cso743395e87.2
        for <linux-mmc@vger.kernel.org>; Thu, 22 Jan 2026 10:03:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769105031; cv=none;
        d=google.com; s=arc-20240605;
        b=Q4H6WlZCeMu/s1Ypru1f117FIZ7wyRPku17WJ9Ht4eiAACaDGVRm5CW3HAHKOokfN8
         4rIVTvGruqUuTYIxv7TczB7D40XOqIiSW8NarmREqkEVnt/TTY7153ASa0feli8cUhyH
         9JAMCQ5RFpWLUPCQOd6uWCsLPF3M/qjMq15d18Si0ie/6tNHQCtu5d+hsBzLDxjp4mRx
         4c99uEpX0EGvE5yuR2QbQvvmkkbsYipZCr37tl7vBmfnf5lvd1dly7FL2KH9GZZlKcx/
         A5pqRo3LqqoH98lDJnHB8YAaLDiMra+166gL3cEdg5tGzgqFZWQ8Vb2uk9W6f79U1Mg+
         GCNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ULAnDKlZBKDexSIIJNiSoAZJoBljSj8ey4FqYBRu3ns=;
        fh=T4MH+Xx2Cd0HGgyyKtCIRmiKyZhncyVFwSKo23lQ8uQ=;
        b=ighC16hJ5G0SoPSYLv0t7yX5npZQ7DZuf+pXfyYmxYS7bg3YVJz6ZFh5GTAsGkx9Xl
         MAhCmQjKptvMLXm+TJwVv4c1poEFUXp4kRzj1qznJ+urDtih06kp2JNuh2ZN8cWu2hXd
         5G8K0YscEtQBXKc9gUa60lwrmImFH0v85IuGpXjy+G5q2Ja9UmQoYpWcVhDCh6AqxspE
         R9FhE8L6coDWzfN18/Ot7ttm3AZiFvoQMhiRXDJfyt1FMRgq2hsqIn33JREyOP5nP8uR
         woINHpdLPbVlYsd/Da5EPr4N8xPyrAc4BV2DOLg4Yy+bxxRYYq+cvmMQ2cCbIok5yvch
         mraA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769105031; x=1769709831; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ULAnDKlZBKDexSIIJNiSoAZJoBljSj8ey4FqYBRu3ns=;
        b=YQnd3lv8ufNgwT9vuEJspaUQzuitMVji4joPgWMLi08TONOOaPpewUO3iLSlWJaXDD
         rgNt1tuNaXf3M0nxw9YghNroMkXhZTRZ+UT/MJ8Cf3P+gzb1JRR6HO0hDkQT6NqCHoRq
         uLgKuPgjnyHMEFOGUJcfmmLSn+U+qMstyuLE4QUKXLnGJL+yZZ2sMNQCrR/VzXKzGK53
         AMQpDljAKEBfytxq5MhXASIK7sR47Vy2aykDx6ffCeQWeOs7KoLsfIc61ywThvzXRcok
         +6DIBCmNHcckUsEFSAc8FcnDK2SgaX/6juc7z/SUOxxsY6BUDukH2glP/+y9f6MouUbO
         kvsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769105031; x=1769709831;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ULAnDKlZBKDexSIIJNiSoAZJoBljSj8ey4FqYBRu3ns=;
        b=kTTSqPc3rpmzb5tJ6cmxYQ+3QptDitSuf7IwPyYenTsX3vXXapBxKpBPw28aY7kAG4
         TChNGO15EYE9MBZaK6a0YNXHvkeT6xscDf3l7tlFKfv+lfOGQ2ydMRsMZ5paZq0CyJgW
         ZU6917b28QOPAiSlljipr8e/EjRVhXir86pfM4Bw4BvkPOUWD317/l2uehvB7gpq0Wq4
         pAYvxvdYVg8qyCSuhPY2sP8LNF4vPZZFGWWePAYoycvA0QlORuiU1oHKWpsFfasMC8Ji
         mgKmxY2J26WPOLgj96rH2sBZCgeUKkgzcCSfJMA98byyUfJyYxkDY7Blrcw1Ccd//oIS
         UHVQ==
X-Gm-Message-State: AOJu0YyHBW+H8QAVfjnn9SNEKmGBT0bZh3RblH3UxHjfmW+BUXsecnFX
	S3xPEMui+CYJ7wj8FbAsiBiv8s5lJJYFkZB45I6LerCnmCaJAmto25de7/j/6Km3KuRL3zRoT2i
	/KprYjPWeWUIeRIm4fHC/OSt4qx4IkLnFvQFieiSWGRFnNAriSUOZ
X-Gm-Gg: AZuq6aLx1ScjLFk4G1OAlwIf+OBBiqAIPT28ZjzkmAy+b7C73GQnnZB9yQQP+oj3+y8
	lf7/t60cUD22SkG4+N+wn4qUlnCED3pDsDoCb8s1MJSijvgVe0/c7PhcIfmzRk/9y4jHZAa2bPK
	uBxZ8CFoHVNopkxRq7ScJcVaYbYOWKlgyPoYcsSPFJprp2jA4cBU4qZNmVYszlWy8DZA6Xt59tk
	e77mNiOAnb9MjgtulpHiZES130ZwyyMGxxT9junmAMW754UfJTX4t+Ue3I4IwUasr8trAEZ
X-Received: by 2002:a05:6512:3f24:b0:598:853e:4868 with SMTP id
 2adb3069b0e04-59de4a2ab4fmr39103e87.53.1769105030643; Thu, 22 Jan 2026
 10:03:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260110144432.176015-1-ahmet@sezginduran.net>
In-Reply-To: <20260110144432.176015-1-ahmet@sezginduran.net>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 22 Jan 2026 19:03:14 +0100
X-Gm-Features: AZwV_Qh8BFaT64ZIHlTbjznd-S7m0EUM3FMZevAkjuidQFqbaKybeZP3GEh8SHw
Message-ID: <CAPDyKFq0a9VjRFQsk=kU63ULwHtZqmq5ocBFj5=GfHhBo8F5DA@mail.gmail.com>
Subject: Re: [PATCH] mmc: pxamci: do not complete requests under host spinlock
To: Ahmet Sezgin Duran <ahmet@sezginduran.net>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 10 Jan 2026 at 15:44, Ahmet Sezgin Duran <ahmet@sezginduran.net> wrote:
>
> pxamci_dma_irq calls pxamci_data_done while holding host->lock, but
> pxamci_data_done is also called from the IRQ handler without the
> lock held and completes MMC requests.
>
> Calling into the MMC core under a spinlock breaks the locking contract
> and may lead to re-entrancy issues.
>
> Drop the host lock before completing the request in the DMA error path.
>
> Found by Coverity: CID#1658802
>
> Signed-off-by: Ahmet Sezgin Duran <ahmet@sezginduran.net>

Applied for next and by adding a stable-tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/pxamci.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
> index b5ea058ed467..6cf65aca2449 100644
> --- a/drivers/mmc/host/pxamci.c
> +++ b/drivers/mmc/host/pxamci.c
> @@ -551,7 +551,9 @@ static void pxamci_dma_irq(void *param)
>                 pr_err("%s: DMA error on %s channel\n", mmc_hostname(host->mmc),
>                         host->data->flags & MMC_DATA_READ ? "rx" : "tx");
>                 host->data->error = -EIO;
> +               spin_unlock_irqrestore(&host->lock, flags);
>                 pxamci_data_done(host, 0);
> +               return;
>         }
>
>  out_unlock:
> --
> 2.52.0
>
