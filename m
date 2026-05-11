Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1408124B28
	for <linux-mmc@vger.kernel.org>; Mon, 11 May 2026 14:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778511183; cv=pass; b=CtoTFDbGg2rt4BcWme/cKGiN5KVaFWaWGLexAUdPGmu9Hc0v1tb9Mez5TH16BOZsAx+Fu8ILwqLdJtUDNy2f2f1i0yn8LfRMXEhdDfzgCVN7WdJMvSevZHEAp6W0P+KbjFFm26mhbffQlYfuLF/WO86FM6ReA7Zxt20ZgderhWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778511183; c=relaxed/simple;
	bh=lwc+bdyrLVdBcpfzRh9VrjXVIAvxjaksZdVUH0pI5Rc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JQ+89W8/caJU24mZ8046yS1THkN0C9goqxOsD//LQCy1eO9qG7x2QzsA0seMwwf1on2vJzwUIzFRzWzcaIwyKb5NnIOxxTiC32onLe8VxGaAiNFRSmlrTjzM6roSdDwvCMRUEmp1ETqxL2QcNYt6qgJAdwYQYA4QBpc3eTxXfiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yafa8rIw; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yafa8rIw"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a8d648466bso855309e87.3
        for <linux-mmc@vger.kernel.org>; Mon, 11 May 2026 07:53:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778511180; cv=none;
        d=google.com; s=arc-20240605;
        b=d2pOX3k9XZfZt/ovi08vbfnDgVOb45p5LoB2ckyz8EnM/jxQi8faSVZ8U2a36z9RZh
         sDOvurHSmLqeukRmdtNuqW4XRnqdzAWpufO5n3irGUWlX5vdmDi0FdLHKT41MlVz1leT
         Qikw8jNPcL9mHek7AvVgmTm22xHK2oleyjBQKoJ9mU2w1MhiKXfZ5vWVv7P8NCT9JCuK
         q2dJLpL4Eo70q+KAsn54ewKhh/CPWFCPlrjx8CfImr6yg9HoBY4QPdWEhcMmptdECaPo
         /VdnXpKpjiHmOIErxPOtBkYIwfVUtXM1REIHSN3rMDw9brohUoiphIA8Fg0d7rAupCrd
         0KvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=7ziP7y+jBujxkAYIyUnUXfhVfL9cOfMmz44d3RhYR+g=;
        fh=/HV9Uguiwv83tm1OKFZVQcFR5OohYSy7u5ZA+rRMP1o=;
        b=V/GIAlxjOweszTfEN3ho/BH9nxX665pZSN0IdeUwieHh76dSKXOYDex6GrPh8r//7C
         1q5TpijmiUeKsWlnIXOB+Tf7cHDfQxYqmtWfzOPztXDHtLutBXyFU12avLmrIxz3aQfx
         e31+Qk+Ze6D6XMd53+KmCCk9fBse+amYJujlkZBFZHYT1zQ5kW5Jb32grnh7B78jOWjs
         ZljugAf32W63Mw3ynkgSV86Zcr43bBzmpicEXhRUFuuccm89FWSxlwx4ASI6JPcl/NfO
         z2yi5FkwJLYylk5AUYWZ34VzLmfYmflf58VisN9YZ22yTFozBVjaxHtZb9s+ECXaSFBE
         tU0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778511180; x=1779115980; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7ziP7y+jBujxkAYIyUnUXfhVfL9cOfMmz44d3RhYR+g=;
        b=yafa8rIwnKWKhh56rJzPG6+0E3Je4gn/K7zxzdoIodbxdnXz/gSdYi6eGVPavURq7d
         5V+n/23Y6d1vBSOa/v/Gse2sl7z8uDgYP/LpRd5U8atAzI8Ngp/mv/mURMJRrj48vncx
         6mJZLkXMeaGqnfds28XS5j1minl1tIqoAPzdNnzlAG+zsLzhjYziNbvQpc8cfv9z07k/
         mrOIyXwpVzdvpSGgWy6hacBj+03v9LfPdHkEUeGPkcWiFYvsdsLtto1t/kfbT1JABfwZ
         A6MrNI9eFjHn1NpmF7Je+3V3hsrRagj0brP3d8gzGRQV4zw/H+hHCwTqo4nlw+704X4E
         2O2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778511180; x=1779115980;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ziP7y+jBujxkAYIyUnUXfhVfL9cOfMmz44d3RhYR+g=;
        b=DfIYbwQxFcgQXq4pPbeXen427YbJsgGHFmmgtCbyJZGmuotERoYyffClFr+Owz3AY1
         VHdYsik9zuxbF6RZVjNZCMVE8VoYZC/r9lXvDrCBIv4E2yLgAmvbvhEZbV6Gl5diWitE
         p/mOl9Q/6ZaYB5juIAuzz7KovVKC3F/o0TqyyhdjNbWO2VtsxsYCF3W0cpnQeF+1+vty
         DcaenwlNr49TukPl4bPQKg8rahf9aG4M5b++hnFBYARTH3z75bM7yPrZGqLQrdVPvSGE
         bvNxsuykGgE+QSj1gj8RfFX6cQazLT7HkEAvdbqwtoLrEG4t276HlD6sQFsMCtLSnQnq
         9aPg==
X-Forwarded-Encrypted: i=1; AFNElJ9qK4FlqaEaOo6+f8Axn41wU+H44BYre4rPfCSxEvLyO8d7zDv6KB/Vfq5zF+O4G5C62qE26RRHg+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuM/Ga6yavtMwaJ5qY3jtydWn51dOizmGlAklIB0Ncth/UR474
	FQdeuxp5cEGNzHoMz6+WHTh2bhVB8gMl0pg/oKPn17ngj8la+5zppCoieSxtojRu6Obk2a/H4iY
	3FEFVq5OBEJcIMFUhMtjTwmvZsomWkyKgpqK8tca90A==
X-Gm-Gg: Acq92OGW28IVHpOxX441/+Ouw92J/4MudbDMVCpSVyIJQqdiMBBZ+5ybNhxRt8P+75w
	JUzFh7xrLNLpHN4PaxyEkDtuK1LwaSYg2JfQ7veLQeKfPDpbLET4rn+EhFN79YAJOP4YsR74VDF
	fm2n6F5Tba3NZCEVKZq2b1JlNyhxIjhLTVDypz7Fh7ygcCcNJ8MwcVZpsgshp/at+N/FHr+h/cf
	96Rib11kI0o1qbamDgTM6vxaZ9tJzcVvLIygQmGDyjJL/+XPnnFnj/9cfnfbVznQ5LYJGDC3BFV
	P3p3QqyJ
X-Received: by 2002:a05:6512:3da2:b0:5a8:73c3:f27b with SMTP id
 2adb3069b0e04-5a887ae05c3mr8163448e87.15.1778511180033; Mon, 11 May 2026
 07:53:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260426112016.1370929-1-inochiama@gmail.com> <20260426112016.1370929-3-inochiama@gmail.com>
In-Reply-To: <20260426112016.1370929-3-inochiama@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 11 May 2026 16:52:21 +0200
X-Gm-Features: AVHnY4Jp8sFXbDsFjZzZloiryDJFcLGgBYUIAOgUw8D4STj0fn7MhtU9ha3Hr3k
Message-ID: <CAPDyKFo-0h_=a5bSS1QFiXtasjRk06ERL7H+X=-U3J1+XX9TBg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] mmc: litex_mmc: Set mandatory idle clocks before CMD0
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Karol Gugala <kgugala@antmicro.com>, 
	Mateusz Holenko <mholenko@antmicro.com>, Gabriel Somlo <gsomlo@gmail.com>, Joel Stanley <joel@jms.id.au>, 
	Paul Mackerras <paulus@ozlabs.org>, Maciej Dudek <mdudek@internships.antmicro.com>, 
	Andy Shevchenko <andy.shevchenko@gmail.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yixun Lan <dlan@gentoo.org>, 
	Longbin Li <looong.bin@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 26 Apr 2026 at 13:20, Inochi Amaoto <inochiama@gmail.com> wrote:
>
> The litex_mmc driver assumes the card is already probed in the BIOS
> and skip the phy initialization. This will cause the command fail
> like the following when the old card is unplugged and then insert
> a new card:
>
> [   62.923593] litex-mmc f0004000.mmc: Command (cmd 8) error, status -110
> [   62.949717] litex-mmc f0004000.mmc: Command (cmd 55) error, status -110
> [   62.976606] litex-mmc f0004000.mmc: Command (cmd 55) error, status -110
> [   63.002516] litex-mmc f0004000.mmc: Command (cmd 55) error, status -110
> [   63.028442] litex-mmc f0004000.mmc: Command (cmd 55) error, status -110
>
> Add required clock settings and initialization for the CMD 0, so it can
> probe the new card.
>
> Fixes: 92e099104729 ("mmc: Add driver for LiteX's LiteSDCard interface")
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> ---
>  drivers/mmc/host/litex_mmc.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/mmc/host/litex_mmc.c b/drivers/mmc/host/litex_mmc.c
> index a8d9c0ece16a..c984398d0803 100644
> --- a/drivers/mmc/host/litex_mmc.c
> +++ b/drivers/mmc/host/litex_mmc.c
> @@ -68,6 +68,9 @@
>  #define SD_SLEEP_US       5
>  #define SD_TIMEOUT_US 20000
>
> +#define SD_INIT_DELAY_US  1000
> +#define SD_INIT_CLK_HZ    400000
> +
>  #define SDIRQ_CARD_DETECT    1
>  #define SDIRQ_SD_TO_MEM_DONE 2
>  #define SDIRQ_MEM_TO_SD_DONE 4
> @@ -142,6 +145,12 @@ static int litex_mmc_send_cmd(struct litex_mmc_host *host,
>         int ret;
>         u8 evt;
>
> +       if (cmd == MMC_GO_IDLE_STATE) {

Rather than doing this explicit check for each command being sent, we
have the ->set_ios() callback where things like this belong. Please
move it there instead.

> +               litex_mmc_setclk(host, SD_INIT_CLK_HZ);
> +               litex_write8(host->sdphy + LITEX_PHY_INITIALIZE, 1);
> +               fsleep(SD_INIT_DELAY_US);
> +       }
> +
>         litex_write32(host->sdcore + LITEX_CORE_CMDARG, arg);
>         litex_write32(host->sdcore + LITEX_CORE_CMDCMD,
>                       cmd << 8 | transfer << 5 | response_len);
> --
> 2.54.0
>

Kind regards
Uffe
