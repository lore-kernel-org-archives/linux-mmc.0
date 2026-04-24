Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C483E123F
	for <linux-mmc@vger.kernel.org>; Fri, 24 Apr 2026 15:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777043546; cv=none; b=Gw4vIajL7UcaUPG2Av2AFfQrq6bfc46BNTZV3+OjSyY/qvep+7ZvqM2Jn5/RBoQi8kFgFiBBwSwN7ro5dcF5Y1ZhT/ccMs6Ht/jBvcB7DZjl20tvfOVvCqJYA3Mlrp4uxmq3jT2yGciw4IzFKBMtXOeuNNrYfDV5nEGEV4Us+3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777043546; c=relaxed/simple;
	bh=erJdZLIXjpiFj3N8atWnldU0PKLgYpyHE6leKr8+BQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OttbwOFkWkKgQ0u7vnq2iHcTsFtf788teTJtvkDTwjfTa2GnLF0sUKx2db1MnzXBahRi6G/aDrpETPbzGhRpo+XUnHJoUOqwCyH3JQ1V9sFpQgebEl1RU1+4uoWV0153bMYquZ91ktW69grx6LZFITRNjb1FIgPk1Sbu7N1qYgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JlfGqdFu; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlfGqdFu"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7de4e6c5a30so1260695a34.0
        for <linux-mmc@vger.kernel.org>; Fri, 24 Apr 2026 08:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777043544; x=1777648344; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jjw6HWmliluIPaGVVPTQRMT/dS3mcAJIKstHR/uFT7o=;
        b=JlfGqdFuSpFMXK09AW1vZE22vUQm++p1sXBfB+VRkM6RfwXKE0OgI0+OziulMldc47
         meEIBpPOz8h1tAsaGo7gktBbudN/6gmfCViohKGRIJQJM65ULeUkn5LtJ3/wHlMcYJNN
         xgK31zgplJ3u0FnDF+/SPyqnN/PKN6uc/7SQg0E+cRNbFWrsebACMCVy2y3wvyXnNjWq
         ETHU/K2aXhiTL+4wkN1gJzlB231caObPIPkQ8bhO8/EVq1dDPdoU28YF9Drx1wJ7jpOj
         E/iJiHn3u0nV+JXWUSgQhKfMORlKZBR7uGSzsQI770qH3D7Qb86h9ptQgTyeJ1kgFNmG
         srzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777043544; x=1777648344;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jjw6HWmliluIPaGVVPTQRMT/dS3mcAJIKstHR/uFT7o=;
        b=LvEh5NFP/bk0cRHPKJky94WLkbjWvJRVBZv2s1NTk02gFuEVhoZpEXs7df2E7we5v7
         KoHbRg7j7prIie085DTf4ugNyBSoGpU01rXE6U5NBBFWM8/wPBOA6JzXvhunwhmclt0b
         nMdTvwFrwZqkLehu1ReNhxH5reVpj14r3FxXKk+a+HYKZ/qG44pYlh+60e+18Ar7AHdJ
         NmTIRlC31eS7Y2xscbyvtIjSWOUqrla+pFQ57qWIB8N2vtPhntUzq599i1j/sSAU2H2D
         LarMLTjYIyRBzydYMy6wVzc09OD8NFw0kd1ksjwe8J4UljdUgmJx2veBlb6nTvmBtf7C
         C1OQ==
X-Forwarded-Encrypted: i=1; AFNElJ+jInf/7ioR7O3mpnl+XHrvjmMgKoEt4bxDF1GtaN7SU71V7Mrgr0ineRV/CX1c4ZEap6li9W2eeLs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOK3IVSedtY4CQlyCajZDpifWomT7Hj1eumT6hOZkc0Ha12Oa8
	za1QJLNf64Z9FrRbjh0yLzeKo3AlybM4K3jz08W219sAj0dBgrHSbLxV
X-Gm-Gg: AeBDieuaYfk+m5iiv6y2MEdIlar9pUAIs3GfjQ02O0epguCjw2Lq1SHjAzl+wL2oTPR
	xg37seORHVoPDpyJ+CnnqJDTyDf23OTs4SDmoTJuKDUTvtRONtvKRJeFHFsbcMDE7faYZalAQQ1
	lY4wuGuyZJJ88+dKxyOCanOWrj3nIfn5nwpM4EUCIH+1oD1KP+CGOY+BY4ZRhjoHR88+bOVor5c
	AfyenTuF6KDtCiKzDYbhm04mVrcam+VQU/KFFhrlYjSsikAlBaohBv+ewHQqvMTJ3v8SU0j2vHb
	gAQ28MeL5gG0F37L1pfOv0Tb/ARtRk6NussZ4FofxwXUOvjGtJAJgB/G6GMkjgEivOzQbL4FtBi
	rLOJwWEWk7aqA0LwAey9zTrl2bP88UcDCXYD1lEw+PWdFipJoSLcHYv0TAsA9SuZGOF9aGLcU1Z
	y2UQyccep1oTCMfVQyIrZxT+KhC6Pw+OpzE1vOhMlXn/UNCf1bXgbxiXmhih979IV1L0dbvk3zJ
	Tv0dP04SjCl
X-Received: by 2002:a05:6820:16ab:b0:694:9b71:3745 with SMTP id 006d021491bc7-6949b713b91mr9212220eaf.57.1777043543632;
        Fri, 24 Apr 2026 08:12:23 -0700 (PDT)
Received: from errol.ini.cmu.edu (pool-108-17-68-229.pitbpa.fios.verizon.net. [108.17.68.229])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e392c7994sm200838951cf.4.2026.04.24.08.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 08:12:23 -0700 (PDT)
Date: Fri, 24 Apr 2026 11:12:21 -0400
From: "Gabriel L. Somlo" <gsomlo@gmail.com>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Karol Gugala <kgugala@antmicro.com>,
	Mateusz Holenko <mholenko@antmicro.com>,
	Joel Stanley <joel@jms.id.au>,
	Kamil Rakoczy <krakoczy@antmicro.com>,
	Paul Mackerras <paulus@ozlabs.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v2] mmc: litex_mmc: Set mandatory idle clocks before CMD0
Message-ID: <aeuIVeIGV2Wc9sY2@errol.ini.cmu.edu>
References: <20260424013615.470325-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424013615.470325-1-inochiama@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett

Hi,

Thanks for the patch!

On Fri, Apr 24, 2026 at 09:36:14AM +0800, Inochi Amaoto wrote:
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
> Change from v1:
> - https://lore.kernel.org/linux-mmc/20260421025052.755471-1-inochiama@gmail.com/
> 1. use fsleep to replace udelay
> ---
>  drivers/mmc/host/litex_mmc.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/mmc/host/litex_mmc.c b/drivers/mmc/host/litex_mmc.c
> index d2f19c2dc673..ac0b47604c02 100644
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
> @@ -99,6 +102,8 @@ struct litex_mmc_host {
>  	bool app_cmd;
>  };
> 
> +static void litex_mmc_setclk(struct litex_mmc_host *host, unsigned int freq);
> +

Instead of the forward reference, can you simply move the entire
`litex_mmc_setclk` function definition to this location in the file?
(i.e., add a separate, "cosmetic" patch simply cut'n'pasting the
function body from one place to another, with a commit blurb stating
that it's in preparation for the idle-clock fix, and that it contains
only cosmetic, no functional changes)?

The idle-clock fix patch can then contain nothing but the
"#define SD_INIT_*" lines and the hunk below:

>  static int litex_mmc_sdcard_wait_done(void __iomem *reg, struct device *dev)
>  {
>  	u8 evt;
> @@ -128,6 +133,12 @@ static int litex_mmc_send_cmd(struct litex_mmc_host *host,
>  	int ret;
>  	u8 evt;
> 
> +	if (cmd == MMC_GO_IDLE_STATE) {
> +		litex_mmc_setclk(host, SD_INIT_CLK_HZ);
> +		litex_write8(host->sdphy + LITEX_PHY_INITIALIZE, 1);
> +		fsleep(SD_INIT_DELAY_US);
> +	}
> +
>  	litex_write32(host->sdcore + LITEX_CORE_CMDARG, arg);
>  	litex_write32(host->sdcore + LITEX_CORE_CMDCMD,
>  		      cmd << 8 | transfer << 5 | response_len);

Thanks much,
--Gabriel
