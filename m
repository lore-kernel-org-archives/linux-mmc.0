Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D3D3ECBF3
	for <linux-mmc@vger.kernel.org>; Thu, 21 May 2026 14:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779374363; cv=none; b=ANku+xTJRAHE5dx6cyje1rsHRp5RBqHm+2aFFuy3sDq9HEPuqfA53PiW8xwPnW2ytmNAGahoAv8Yvy6SxXAZ8pC2brrMSoNWtSTbECmpSZ4lqtg7i6mKV3yCNO0f9aN73TbTA/dmSDuCaPiDpnijZeRr3TdjlLTVvxH9U86wjVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779374363; c=relaxed/simple;
	bh=gc2c+KKlTReJahaT44nICjR03THjsFcQdduzS5vCeAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cJcyH7zfIBTXLuBPdS1fqV0v2YoATC0d8jmGQUrkFmI3ct5brd3XciSwZk6Rkn8u6IKGmHsz0W+pgKWXNuQeT9rONxzzAVBdU22/L1gAmFy9mvNtV/q4difooRurf4eEm5dS41MseFwTGS8xDSD1wFrIye7LxPd4nle18xluFiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OQyHjVML; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OQyHjVML"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8b5cda2dab9so70243306d6.0
        for <linux-mmc@vger.kernel.org>; Thu, 21 May 2026 07:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779374361; x=1779979161; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gTr8u/snY8J1atN0wkQzIVSY3v3e30g1Wn+GFVhT/Zc=;
        b=OQyHjVML1UnhVpnyliO9Kq6LJkD/88/CnjsU82VMp90UBHth5ple+AjU+1DmgnicHr
         2P7glTRsbIyLkO6ujfS5AAJkWko0rUdLFLSbEKW92tsLY2VjesWUEbLwnEdIMgeoshBw
         B9ZfNElNVjtPrWq7a/NQE2gKGrjLEvKPEX5teF3kaqyX0IVlb/mAXKd70gh/A4MmMs67
         6k0TaVRFJKFp/G8fGWe7UCfZpjevNfx84tSc9p0ghyuU56b6nj+djWMAb03UawY9QLHF
         zxnOxnuZqJ5xm3BlGldobg0VtIsELPrwgRBtliiU705gzOXuk+0z0cactFzYB4NOmDHG
         Warw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779374361; x=1779979161;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gTr8u/snY8J1atN0wkQzIVSY3v3e30g1Wn+GFVhT/Zc=;
        b=YOh7IZvMDVVDrH+eVixvtTkEF/SozgPyJbWAQQ93wqFWleEWSGyYs42AWVBQWuqHKj
         sSDfQVbCoS4TDZ9ubrzBP6crLo1E81LAyrEnAll/cUTNiqJx1UOBXv1RR8YfiJXCIRQO
         llfuStG701kmTu7q/LLDVZkRoRYf0HWn8MdpYUx5kCGTcW3CL1Zs7P+M9WGoGke7Wn9h
         80VjK3pT6P+ArZgP7ck6XcHfZMIlRYD3NuDlAVdDdga75JqFq2Wu2X/PHzz4yNNxVmhv
         DiseEU9bht76AJ+YBTW7eJn3NmRGJlGDMLyUvxJ1ztY9mbQEFv2nI7SjZvxNcupYUL6E
         O/vA==
X-Forwarded-Encrypted: i=1; AFNElJ8hMTmJb7YH+DN1t582ymcTgdyEZM0Ga2ugoF6IecXVpCUzI2AfxGP+dXLu07FDdymN7ws5Hg7MMtA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3CI/cnuNB2PHUF7B6DW3AniPMzMR8/u3JUkyI4RwDBXksuGp+
	RB8uWzjpUACetGlVdIGS0QNvUw6Kcj+o/IyjMvCX7kxx0T9ejFaUFuoQXDlwOP03
X-Gm-Gg: Acq92OEC6zfRCqvlZqKFBOXpondJASEnaB5iuO9F8WDMf2jNswEo0yOG1kQ6G2pjUAS
	XaSglEJ9CP+J2zgVzFFncqgii+KEa6oK97XH4W9+GMZV10mGnexc9szPOZ/DoOxfTePlz7RChx8
	Wm1/SrfUOPOqtxQbiovc7rJDfI8X6ocv/j55eZUf0BCaZG+IooAPO42kNxkgJUrAT7m7w1pyHgF
	qccSrSA1OKakdxX42Jv7MXBqMW3wY4wacDOAAv/Dtxcm9sXiBiu6CYLOCEan30E01jATbOLUAYn
	OlpsUcmiQFr0R3CgO2CgyT9EQy+kOQc4xVQLytSUJfcUeLt0/2bXvATutP7ICpJ2YjCMvweU12C
	PfmrEh/5sU5cMTRsijBJNnQRsn7l9BuRyFW2wM/aUMooGG1Xup74YYUxLc+7HWknVYXJaxFvd5b
	T2fJ9svsACPGA1tMFPcsqjEBSXZOJUMo3fWgs3y3vFov9uyVuP5kydiLGBWRv8KIOmBH3HLIhGb
	2nGQ7+L4sNq
X-Received: by 2002:a05:6214:e42:b0:89c:da2b:d137 with SMTP id 6a1803df08f44-8cc6e6f2dcdmr37444316d6.33.1779374360572;
        Thu, 21 May 2026 07:39:20 -0700 (PDT)
Received: from errol.ini.cmu.edu (pool-108-17-68-229.pitbpa.fios.verizon.net. [108.17.68.229])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc768d4ea4sm6451956d6.13.2026.05.21.07.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 07:39:20 -0700 (PDT)
Date: Thu, 21 May 2026 10:39:18 -0400
From: "Gabriel L. Somlo" <gsomlo@gmail.com>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Karol Gugala <kgugala@antmicro.com>,
	Mateusz Holenko <mholenko@antmicro.com>,
	Joel Stanley <joel@jms.id.au>,
	Maciej Dudek <mdudek@internships.antmicro.com>,
	Paul Mackerras <paulus@ozlabs.org>, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v5 0/2] mmc: litex_mmc: Set mandatory idle clocks before
 CMD0
Message-ID: <ag8ZFgw3bEOJmO2c@errol.ini.cmu.edu>
References: <20260521072122.1601215-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521072122.1601215-1-inochiama@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett

On Thu, May 21, 2026 at 03:21:19PM +0800, Inochi Amaoto wrote:
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
> Firstly, fix the clock divider calculation so we can get the right
> clock frequency, then add required clock settings and initialization
> for the CMD 0, so it can probe the new card.
> 
> Test Results:
> Rocket:
> # dmesg | grep mmc
> [    0.109176] litex-mmc 12003000.mmc: LiteX MMC controller initialized.
> [    0.256926] mmc0: new SDHC card at address aaaa
> [    0.257058] mmcblk0: mmc0:aaaa WC32G 29.7 GiB
> 
> Note: it seems like the rocket give a wrong DMA result when the target
> address is in main memory.
> See issue: https://github.com/enjoy-digital/litex/issues/2464
> 
> VexiiRiscv:
> # dmesg | grep mmc
> [    2.368365] litex-mmc f0004000.mmc: LiteX MMC controller initialized.
> [    2.576993] mmc0: new SDHC card at address aaaa
> [    2.588966] mmcblk0: mmc0:aaaa WC32G 29.7 GiB
> [    2.620197]  mmcblk0: p1

For the whole series:

Reviewed-by: Gabriel Somlo <gsomlo@gmail.com>

Thanks,
--Gabriel
 
> Changed from v4:
> - https://lore.kernel.org/linux-mmc/20260517015323.264179-1-inochiama@gmail.com/
> 1. Add a new patch for fixing clock divider calculation
> 2. Move everything in the set_ios() callback.
> 
> Changed from v3:
> - https://lore.kernel.org/linux-mmc/20260426112016.1370929-1-inochiama@gmail.com/
> 1. Remove patch 1: mmc: litex_mmc: Move litex_mmc_setclk() to bottom for reuse
> 2. Use set_ios() callback to apply the clock change.
> 
> Changed from v2:
> - https://lore.kernel.org/linux-mmc/20260424013615.470325-1-inochiama@gmail.com/
> 1. Remove the added function forward reference and add a new patch
>    for moving litex_mmc_setclk() function
> 
> Change from v1:
> - https://lore.kernel.org/linux-mmc/20260421025052.755471-1-inochiama@gmail.com/
> 1. use fsleep to replace udelay
> 
> Inochi Amaoto (2):
>   mmc: litex_mmc: Use DIV_ROUND_UP for more accurate clock calculation
>   mmc: litex_mmc: Set mandatory idle clocks before CMD0
> 
>  drivers/mmc/host/litex_mmc.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
> 
> --
> 2.54.0
> 
