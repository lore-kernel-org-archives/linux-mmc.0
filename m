Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEC142E000
	for <linux-mmc@vger.kernel.org>; Wed, 21 Jan 2026 10:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768990423; cv=pass; b=pbZl7ks6Ye5lunGeRRV1dAdx1oYkddUTzlcryFYYcWOQ4NcVRYmwBGv/kX8OS0Xiq8D1Ewyx8qgyxsNSUv0mR52x+ERvhZkEGqcxImWjluTkrKp4MOxsAVzemLH9XLywZ4EDM7N1Me/yMM5P7i8R6dOFadfq4y465MW2cU0UdAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768990423; c=relaxed/simple;
	bh=6DCfspdJDhzmigRzyYHjs9jJhl6CF8SnO82nc++HNuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DZdT7OYqs3s3ABeVGEGYYHOdE2y6RogMJwybMBFZNaMSYQfZhqVn/IJXdsqiEUeM5Ss8OUHmJ0hycO1hM0v+UITlOrzJYqfgCP6h+fUIcBu/23abStsj0+yK1s2E6BZ40jwzvC5728wy8ZqcR2sLFRdLmBO1A7UwXTwMTgHUMB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PoIi6mdi; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PoIi6mdi"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-59b79451206so5768096e87.1
        for <linux-mmc@vger.kernel.org>; Wed, 21 Jan 2026 02:13:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768990419; cv=none;
        d=google.com; s=arc-20240605;
        b=DHqJ+XBrOvuBkOlH1RrUwjH5RSSA7Aa9sTBPpyGx2ihdUw2JMyeAm5Kg4I9FluStER
         UtghBLkZbCufn9vd0dNddr5fFd556QXA3eI37jlEv7mRFCPg+2UzJ76Q2zjoGbEmvRs5
         32u2XkFAsYqw9B1RPnNWPAwTcEzarGXhgo7os+nJoiooHv3Ta8xusfvrwc6/zx94nu8Q
         wCt/S4I5+7ifouYOBhww4nGBjR4F6aMKyqh5xaq76Diuxu2qFI8wLGdoKwt6cEXohtit
         gQnS0P4jDqCGB6HG7hf+Dn+W4NV11XFbQXxfV++8+UKtgLGFZisH38+55VKUTNQQWPaY
         E+Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=36bIbYK3MtK1cWYhPBtCXZHXMGIRLoboyU5uxmXHH9Y=;
        fh=kexRyz+bm+5KfxjN7LdNPbUEdTXR6BrPz5GyTPnLAqk=;
        b=bGk4GMENpBpf+yiI+krT1piH4pfRb1PJmABigaBPcopv4CsINWG5F9PnFYx6U0euNH
         IliZSP+dt2zpSlCXTujua23nfeBRkyh6w3R6MtJ40WiKUbppTZJo7puqP0f3OMbOsrGE
         wJkYXDwn10uj4FxcpJ9A62s49txoIphkkh14OBKegGl1wlPJ614tBdRRpuAUIvI2Jl0X
         D6+844X/lL6xwBQhn70L0jaLWZSu8IWqOSkeqDgY7EhpKwEh3yB1/wbxxIf4z7wjwYIQ
         Jd0q1izC7qGYqx5HnJvRbM0Eeg1wsJesbIyp83VOjzpBhpsyFPn2KJ2BR7/Khu9o/fxq
         hf0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768990419; x=1769595219; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=36bIbYK3MtK1cWYhPBtCXZHXMGIRLoboyU5uxmXHH9Y=;
        b=PoIi6mdiV9zUkHNtWMBm8Dq7szj4hJNlNM7xgy6fJHCPK/8OK3QaJ0JiMN5opqivxY
         FqJSvqRD7v1o3kMFMb++GE1KE/FFIS09I0FHdwB8qPumX3KtAH6Kr+q4/mDkqSkUvVCo
         dYSZ+NlEiS5PJ3URBYZ584nBWCQNZdfO/hEEIVPcwCXDBnvebFP2bIlElkWN0gnnJwju
         ybjNY9rV5C3e5m4eNYZZkIQVicRz+r9tLCfDRpTQ9XpJ96fuqqhtfUiH3dUZQO625O/k
         AN9Jnxl/qBwXirXhks5z2eQF7V4I43lnr3Z7LXSjR8fZMcgcJKqjhEzb4iXMFz85gUcn
         dmkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768990419; x=1769595219;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=36bIbYK3MtK1cWYhPBtCXZHXMGIRLoboyU5uxmXHH9Y=;
        b=GIH9qytwAybbTqQd8/5Aswb7TD/ZQ+70nbDt3nzXzx5m0DTNAvxiayMHSXKe5Jx5MM
         kGQxnHOxct0dSTaPKs6pstiRoo8Ifz35FWluTKPXrHmQqVQ5V90SKfZGBBMn0xtV7TL0
         L7qjLTRLyRb/laZBelKNJkNKTpoxja31n5foSR4WI5fd7jqFF4Hfmn3Mp9uJi9lEGsBz
         J2VnCprFOMMqKWEk3+FGHygOzw4HeRFDzaAlnzc89rpsRI/z0NrcDkrJ3NGsLfqa4qS6
         xRDiTYt3K62ekD6nmoQViIlmX+jaTJBQzny5c6viExKnEOMPJPK1beSbStGgAMHkXoVn
         j17Q==
X-Forwarded-Encrypted: i=1; AJvYcCUBMuMR8miAjh4LXq2xlGAAifaLKYKKlHqYwXzqBC2/d2XyY8p+Yv/fVCQR+qcLwQqTs44BG3ySC3I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfssmk6uJT5hEFXIeWLpaSnnao2PHyvSLGNADsvR445eMpipU5
	spkaZn/Bnm764RF/p63MG6JZBwUvLf+3qmxQ8KoEbw7rx99v1acWilBwsRAVlhlS3rvumJD0+r5
	/PRjUm6NvX5UHlQ5Ee2Ub5a+KBG0oI7L+pnAX+fDCTw==
X-Gm-Gg: AZuq6aLD0wg0y22UnJDNiwLK/9YHuEDJW9ZE3fF4razXOCAbm37rCrcFanQnLKD7G8R
	hbj2i+X9+Hhb5uZzAVTzWBo2OBY5TEvFynveqL4KcmZ1AELPAjrn0vICJOcE9Vauxl7UEZLBGTu
	cosMlx94fHWkKmoJawShw3a7bGj+zslEkgSYVkyVXr8wYHuIcG1Z9+P2LualtpNoQF2KC4dXL3z
	lI/V81LVY/lGUk0nP+AYc9rUb+I0Hf+ssSKr19Q7hhyPaDgn+30th2MeNjBsf36B0q/++Ji
X-Received: by 2002:a05:6512:61a8:b0:595:7f66:b6a with SMTP id
 2adb3069b0e04-59dc9350aeemr1634134e87.35.1768990419326; Wed, 21 Jan 2026
 02:13:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105060236.400366-1-matthew.schwartz@linux.dev>
In-Reply-To: <20260105060236.400366-1-matthew.schwartz@linux.dev>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 21 Jan 2026 11:13:03 +0100
X-Gm-Features: AZwV_QhXOgfkSJHmLAUv1HRpcB1xB2FSZ4hz1qO6PEtBw2e_W4hfYSVqvrsfKD4
Message-ID: <CAPDyKFozgK_W98=-wqE2fxBsSkKvCU=mYH7WkKVXQPiB3+og3w@mail.gmail.com>
Subject: Re: [PATCH 0/2] mmc: rtsx: card stuck busy fixes for Realtek PCI SD
 card readers
To: Matthew Schwartz <matthew.schwartz@linux.dev>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Ricky Wu <ricky_wu@realtek.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 Jan 2026 at 07:02, Matthew Schwartz
<matthew.schwartz@linux.dev> wrote:
>
> This series fixes some SD card timeout errors that occur after suspend and
> resume ops on systems with Realtek PCI card readers. These issues occur on
> my 2 RTS525A card readers and my RTS5261 card reader.
>
> As a stress test, I ran the amd-s2idle script from amd-debug-tools to
> automate s2idle cycles and I launched a visual novel, WITCH ON THE HOLY
> NIGHT, from the SD card. Visual novels are basically just slideshows, and
> waiting for 10 seconds without advancing the text is an easy way to
> trigger rtsx_pci_runtime_suspend/rtsx_pci_runtime_resume. I set amd-s2idle
> to test with a 10 second long s2idle length with 13 seconds between runs.
>
> The main symptom that always shows up is "mmc0: Card stuck being busy!"
> followed by timeouts and filesystem errors. This can occur during both
> runtime resume and s2idle resume:
>
> [  260.638214] mmc0: error -110 doing runtime resume
> [  261.054214] mmc0: card d555 removed
> [  261.054382] Aborting journal on device mmcblk0p1-8.
> [  261.054386] JBD2: I/O error when updating journal superblock for mmcblk0p1-8.
> [  261.067729] EXT4-fs (mmcblk0p1): shut down requested (2)
>
> Patch 1 adds a power_off callback so rtsx_pcr can notify the sdmmc driver
> during suspend, allowing it to reset prev_power_state. This ensures
> sd_power_on properly reinitializes the card on resume. It reduces the
> failure rate of "mmc0: Card stuck being busy!" after resume from 20% down
> to 4%.
>
> Patch 2 increases the post-power-on settling delay from 1ms to 5ms. The
> shorter delay seems insufficient for reliable reinitialization after the
> hardware has been powered off during suspend. Increasing this reduces the
> failure rate from 4% down to 0%, tested with over 300 s2idle cycles.
>
> Matthew Schwartz (2):
>   mmc: rtsx: reset power state on suspend
>   mmc: rtsx_pci_sdmmc: increase power-on settling delay to 5ms
>
>  drivers/misc/cardreader/rtsx_pcr.c |  9 +++++++++
>  drivers/mmc/host/rtsx_pci_sdmmc.c  | 24 +++++++++++++++++++++++-
>  include/linux/rtsx_common.h        |  1 +
>  3 files changed, 33 insertions(+), 1 deletion(-)
>
> --
> 2.52.0
>

Greg, looks like you have queued up these patches via your misc tree,
can you please drop them? We need a different approach to the problem.

Kind regards
Uffe
