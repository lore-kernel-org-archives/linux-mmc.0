Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5606921B9C0
	for <linux-mmc@vger.kernel.org>; Sat,  3 Jan 2026 11:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767440291; cv=none; b=sru9J77KfRZbA9j15sZNrqFWkcetTjVTKixl32YW6Wu93Yr2Tareg0wcqU8wHX3EwTmlVsxnB/3ZrzC9I0yG8qCgkxZ6flk/SH/w/X95AE7fFm18pmEJW/DHnu64u+MqXlE/SaWEDELVWt+ncc5ip4A30/+diB/ItKaPbyqefTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767440291; c=relaxed/simple;
	bh=euT9hejleFK55/iR3w/hJMxhYqIOOmxnAa4382Vf8+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jThsMnWHKdmOEXXTUkCgX14HvJj0g1/BxJgcyjYe23c+qcV5gs/k6lK5K9uKS5teG45t0CTtjqXZOqsw10eoeAKV5HPhCaYYtTWJLgeQpahEfUqiKGcFT5+OLWKZUAJGa8kqDsYwxk11ThSUOvj2PSzQd2nR+yu5cyTzKfWTPok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lIbCQ49D; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lIbCQ49D"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-37fdb95971eso94750811fa.1
        for <linux-mmc@vger.kernel.org>; Sat, 03 Jan 2026 03:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767440283; x=1768045083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EcFIQlhEs1oy4XqieSkncLveAgShE9OEBxqGyI7z0Hw=;
        b=lIbCQ49DrqL81qYfMm6Dkp3MWbMHUMnTkjxRwM5wKNiBozVG2aAnqAwQNQrKZZXbtS
         xZD4M8l8ygZ7hZas82ksEURxeYe+p4sbyuVkqvWx6op68V0owKLLisULJsb24Kq0hDY5
         eJ9vp1TjHL6IV6Dx0sPmdXvKWWhZ1oqyOo/+tKDjRAfs54lh7NIdWsYTdrZKpSkmqqK1
         MGZy8l31nziQlVNvAVVGJBbxf24CPcFZavkENHIJ5UsfU7L6NHc0PoLsjEq4RDfrx2YP
         9gm3l0KUat8ABoJ//lPW2uKcAn7lZMMtRW8T27GyPvPgBj0WmjiCx4yXvZcqYNjzp6aH
         RH/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767440283; x=1768045083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EcFIQlhEs1oy4XqieSkncLveAgShE9OEBxqGyI7z0Hw=;
        b=ozJffEozhpRUD966tZgtJ8Mi/tAhFjCAkGkDRvJSVq1YQqzBM+V5JjK59Uyo+ilytd
         z+oSRKr3ObNDxuJ0lakJkB1rijN4pVDDbY9GTrFeSpaLQmSNxWMyjkYs16wGIlu6nBMh
         6bM/AHK40yoTObGOpO/HcjyXfXL1Kqb/Q4/d2HwCnmed3977Y/gQX4/87PrrG/mOX9Pb
         sqjrzjhFBVo1sWRUaXrQ5ScAW6Na4XnibLYyf3+V6DOPsHhIuPBsk2J4JuD90XVokmtn
         xkCSyC3alXjlNGPjwO8XZoV1b0oUbtJzZck3HMJ/+IXxxK0bAp4ayU0GBbWq6B5A7ulc
         MGRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdV0h2AOVC9zBCxfS/QHOXhOTeWZyu8zOLk/QZiFovk0i1R5ox2bHue7hA7RMpidWWUf2ZHIvC5aE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPueLFWPC7jT4yYGJrBKcqsR914ibc+qQ9QlXq6guWiqW3QQZL
	GCaWqMIytyusWWQm0AKDfjcgogJVEiC14NkBS+NXN1ObH77ZPM+0odne5S+eZMruD69+MMWssnA
	5ELRRwNFBJlGxNzCbbker6dTHI0SaYW0NWoaLlf6caQ==
X-Gm-Gg: AY/fxX5jCtBM03TE/Q+kuQGp/V6UQaz37wwPD441/WIUJEsFGXV8NCtcP6Lwl2hAGho
	GjvGGlVREaqRUodp1BMN8EZdXIZVj1VngRmvCb86j/+R+QSU0hRThp9BGAa/WN4ifcZPGj3Ib4Y
	5dnd2WynVBcAvyq0+3szgNPUCuNBjS6pqnIPmWtH8lJGDuDTsGlznE/ynZ1NyzByPZhntrLAK6w
	CLhM5dNVJCE3o7GlYwLUVNJZDboLnsuAarW4GXQUmeNoNPRoDIalkq7IQ4rahsTZrpBwZfZ
X-Google-Smtp-Source: AGHT+IEn3Q2W61xlXIhjjBtzz7ZUTkfsbSEclvqGj6bSffM1J0eCT/3Ttw1R5OhY2q/NEcWXwI9HhB9SkP71f+cwFDA=
X-Received: by 2002:a2e:bc12:0:b0:37b:97b7:a048 with SMTP id
 38308e7fff4ca-381215c8dd7mr142650521fa.17.1767440281814; Sat, 03 Jan 2026
 03:38:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ff9a7c20-f465-4afa-bf29-708d4a52974a@linux.dev>
In-Reply-To: <ff9a7c20-f465-4afa-bf29-708d4a52974a@linux.dev>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Sat, 3 Jan 2026 12:37:25 +0100
X-Gm-Features: AQt7F2rsk92SJKN3--D8CZQr1pGPMmSQYRKvB82gPe4-CFyNVRfzJqjyCvv2Lro
Message-ID: <CAPDyKFrGpvjONrDmnNZXv+SME_NCNv-LK8J-Vo88RSz1fuD7rg@mail.gmail.com>
Subject: Re: [BUG] - Short freezes in gameplay due to MMC_CAP_AGGRESSIVE_PM on
 RTS525A card reader
To: Matthew Schwartz <matthew.schwartz@linux.dev>
Cc: Ricky Wu <ricky_wu@realtek.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 24 Dec 2025 at 22:01, Matthew Schwartz
<matthew.schwartz@linux.dev> wrote:
>
> Hello,
>
> I have several handheld devices that have a Realtek Semiconductor Co., Lt=
d. RTS525A PCI Express Card Reader and I am running into an issue on all of=
 them when I try to play games off of my SanDisk Extreme PRO Micro SD cards=
.
>
> I have two SD cards, a 1TB and a 2TB model, and while playing games off o=
f either one there are frequent freezes in gameplay. When this happens, the=
 kernel has some mmc and rtsx errors:
>
> [   41.348311] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_send_cmd_get_rsp: SD/M=
MC CMD 13, arg =3D 0xd5550000
> [   41.354004] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[0] =3D 0x000009=
00
> [   41.354020] rtsx_pci 0000:c0:00.0: Switch card clock to 208MHz
> [   41.354021] rtsx_pci 0000:c0:00.0: Internal SSC clock: 208MHz (cur_clo=
ck =3D 208)
> [   41.354026] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
48, arg =3D 0x08000200
> [   41.354235] rtsx_pci 0000:c0:00.0: Switch card clock to 30MHz
> [   41.354236] rtsx_pci 0000:c0:00.0: Internal SSC clock: 30MHz (cur_cloc=
k =3D 208)
> [   41.354237] rtsx_pci 0000:c0:00.0: n =3D 118, div =3D 3
> [   41.354237] rtsx_pci 0000:c0:00.0: ssc_depth =3D 1
> [   41.601291] rtsx_pci 0000:c0:00.0: --> rtsx_pci_runtime_idle
> [   51.521666] rtsx_pci 0000:c0:00.0: --> rtsx_pci_runtime_suspend
> [  101.898966] rtsx_pci 0000:c0:00.0: --> rtsx_pci_runtime_resume
> [  101.899052] rtsx_pci 0000:c0:00.0: RTSX_BIER: 0x36400000
> [  101.910028] rtsx_pci 0000:c0:00.0: Power OFF efuse!
> [  102.025901] rtsx_pci 0000:c0:00.0: Switch card clock to 30MHz
> [  102.025907] rtsx_pci 0000:c0:00.0: Internal SSC clock: 30MHz (cur_cloc=
k =3D 30)
> [  102.025911] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sdmmc_switch_voltage: sig=
nal_voltage =3D 0
> [  102.031892] rtsx_pci 0000:c0:00.0: Switch card clock to 30MHz
> [  102.031900] rtsx_pci 0000:c0:00.0: Internal SSC clock: 30MHz (cur_cloc=
k =3D 30)
> [  102.037892] rtsx_pci 0000:c0:00.0: Switch card clock to 30MHz
> [  102.037899] rtsx_pci 0000:c0:00.0: Internal SSC clock: 30MHz (cur_cloc=
k =3D 30)
> [  102.039168] rtsx_pci 0000:c0:00.0: Switch card clock to 30MHz
> [  102.039172] rtsx_pci 0000:c0:00.0: Internal SSC clock: 30MHz (cur_cloc=
k =3D 30)
> [  102.039177] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_send_cmd_get_rsp: SD/M=
MC CMD 0, arg =3D 0x00000000
> [  102.040763] rtsx_pci 0000:c0:00.0: Switch card clock to 30MHz
> [  102.040764] rtsx_pci 0000:c0:00.0: Internal SSC clock: 30MHz (cur_cloc=
k =3D 30)
> [  102.041874] rtsx_pci 0000:c0:00.0: Switch card clock to 30MHz
> [  102.041875] rtsx_pci 0000:c0:00.0: Internal SSC clock: 30MHz (cur_cloc=
k =3D 30)
> [  102.041879] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_send_cmd_get_rsp: SD/M=
MC CMD 8, arg =3D 0x000001aa
> [  102.042452] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[0] =3D 0x000001=
aa
> [  102.042468] rtsx_pci 0000:c0:00.0: Switch card clock to 30MHz
> [  102.042469] rtsx_pci 0000:c0:00.0: Internal SSC clock: 30MHz (cur_cloc=
k =3D 30)
> [  102.042474] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_send_cmd_get_rsp: SD/M=
MC CMD 55, arg =3D 0x00000000
> [  102.043036] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[0] =3D 0x000001=
20
> [  102.043053] rtsx_pci 0000:c0:00.0: Switch card clock to 30MHz
> [  102.043057] rtsx_pci 0000:c0:00.0: Internal SSC clock: 30MHz (cur_cloc=
k =3D 30)
> [  102.043061] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_send_cmd_get_rsp: SD/M=
MC CMD 41, arg =3D 0x59300000
> [  102.043599] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[0] =3D 0x00ff80=
00
> [  102.062878] rtsx_pci 0000:c0:00.0: Switch card clock to 30MHz
> [  102.062885] rtsx_pci 0000:c0:00.0: Internal SSC clock: 30MHz (cur_cloc=
k =3D 30)
> [  102.062890] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_send_cmd_get_rsp: SD/M=
MC CMD 55, arg =3D 0x00000000
> [  102.063450] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[0] =3D 0x000001=
20
> [  102.063462] rtsx_pci 0000:c0:00.0: Switch card clock to 30MHz
> [  102.063463] rtsx_pci 0000:c0:00.0: Internal SSC clock: 30MHz (cur_cloc=
k =3D 30)
> [  102.063467] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_send_cmd_get_rsp: SD/M=
MC CMD 41, arg =3D 0x59300000
> [  102.064012] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[0] =3D 0x00ff80=
00
> [  102.104036] rtsx_pci 0000:c0:00.0: Switch card clock to 30MHz
> [  102.104043] rtsx_pci 0000:c0:00.0: Internal SSC clock: 30MHz (cur_cloc=
k =3D 30)
> [  102.104047] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_send_cmd_get_rsp: SD/M=
MC CMD 55, arg =3D 0x00000000
> [  102.104603] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[0] =3D 0x000001=
20
> [  102.104619] rtsx_pci 0000:c0:00.0: Switch card clock to 30MHz
> [  102.104620] rtsx_pci 0000:c0:00.0: Internal SSC clock: 30MHz (cur_cloc=
k =3D 30)
> [  102.104624] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_send_cmd_get_rsp: SD/M=
MC CMD 41, arg =3D 0x59300000
> [  102.105162] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[0] =3D 0x00ff80=
00
> [  102.184867] rtsx_pci 0000:c0:00.0: Switch card clock to 30MHz
> [  102.184874] rtsx_pci 0000:c0:00.0: Internal SSC clock: 30MHz (cur_cloc=
k =3D 30)
> [  102.184878] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_send_cmd_get_rsp: SD/M=
MC CMD 55, arg =3D 0x00000000
> [  102.185438] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[0] =3D 0x000001=
20
> [  102.185446] rtsx_pci 0000:c0:00.0: Switch card clock to 30MHz
> [  102.185447] rtsx_pci 0000:c0:00.0: Internal SSC clock: 30MHz (cur_cloc=
k =3D 30)
> [  102.185451] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_send_cmd_get_rsp: SD/M=
MC CMD 41, arg =3D 0x59300000
> [  102.185990] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[0] =3D 0x00ff80=
00
> [  102.265861] rtsx_pci 0000:c0:00.0: Switch card clock to 30MHz
> [  102.265868] rtsx_pci 0000:c0:00.0: Internal SSC clock: 30MHz (cur_cloc=
k =3D 30)
> [  102.265872] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_send_cmd_get_rsp: SD/M=
MC CMD 55, arg =3D 0x00000000
> [  102.266434] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[0] =3D 0x000001=
20
> [  102.266450] rtsx_pci 0000:c0:00.0: Switch card clock to 30MHz
> [  102.266452] rtsx_pci 0000:c0:00.0: Internal SSC clock: 30MHz (cur_cloc=
k =3D 30)
> [  102.266456] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_send_cmd_get_rsp: SD/M=
MC CMD 41, arg =3D 0x59300000
> [  102.266996] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[0] =3D 0x00ff80=
00
> [  102.346859] rtsx_pci 0000:c0:00.0: Switch card clock to 30MHz
> [  102.346869] rtsx_pci 0000:c0:00.0: Internal SSC clock: 30MHz (cur_cloc=
k =3D 30)
> [  102.346875] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_send_cmd_get_rsp: SD/M=
MC CMD 55, arg =3D 0x00000000
> [  102.347441] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[0] =3D 0x000001=
20
> [  102.347450] rtsx_pci 0000:c0:00.0: Switch card clock to 30MHz
> [  102.347451] rtsx_pci 0000:c0:00.0: Internal SSC clock: 30MHz (cur_cloc=
k =3D 30)
> [  102.347455] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_send_cmd_get_rsp: SD/M=
MC CMD 41, arg =3D 0x59300000
> [  102.348005] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[0] =3D 0x00ff80=
00
> [  102.427853] rtsx_pci 0000:c0:00.0: Switch card clock to 30MHz
> [  102.427860] rtsx_pci 0000:c0:00.0: Internal SSC clock: 30MHz (cur_cloc=
k =3D 30)
> [  102.427865] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_send_cmd_get_rsp: SD/M=
MC CMD 55, arg =3D 0x00000000
> [  102.428434] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[0] =3D 0x000001=
20
> [  102.428443] rtsx_pci 0000:c0:00.0: Switch card clock to 30MHz
> [  102.428444] rtsx_pci 0000:c0:00.0: Internal SSC clock: 30MHz (cur_cloc=
k =3D 30)
> [  102.428448] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_send_cmd_get_rsp: SD/M=
MC CMD 41, arg =3D 0x59300000
> [  102.428995] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[0] =3D 0x41ff80=
00
> [  102.508837] rtsx_pci 0000:c0:00.0: Switch card clock to 30MHz
> [  102.508845] rtsx_pci 0000:c0:00.0: Internal SSC clock: 30MHz (cur_cloc=
k =3D 30)
> [  102.508852] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_send_cmd_get_rsp: SD/M=
MC CMD 55, arg =3D 0x00000000
> [  102.509408] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[0] =3D 0x000001=
20
> [  102.509440] rtsx_pci 0000:c0:00.0: Switch card clock to 30MHz
> [  102.509445] rtsx_pci 0000:c0:00.0: Internal SSC clock: 30MHz (cur_cloc=
k =3D 30)
> [  102.509452] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_send_cmd_get_rsp: SD/M=
MC CMD 41, arg =3D 0x59300000
> [  102.509996] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[0] =3D 0xc1ff80=
00
> [  102.510008] mmc0: cannot verify signal voltage switch
> [  102.510031] rtsx_pci 0000:c0:00.0: Switch card clock to 30MHz
> [  102.510033] rtsx_pci 0000:c0:00.0: Internal SSC clock: 30MHz (cur_cloc=
k =3D 30)
> [  102.510038] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_send_cmd_get_rsp: SD/M=
MC CMD 11, arg =3D 0x00000000
> [  102.510587] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[0] =3D 0x000003=
20
> [  102.511837] rtsx_pci 0000:c0:00.0: Switch card clock to 30MHz
> [  102.511838] rtsx_pci 0000:c0:00.0: Internal SSC clock: 30MHz (cur_cloc=
k =3D 30)
> [  102.511840] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sdmmc_switch_voltage: sig=
nal_voltage =3D 1
> [  102.598474] rtsx_pci 0000:c0:00.0: Switch card clock to 30MHz
> [  102.598480] rtsx_pci 0000:c0:00.0: Internal SSC clock: 30MHz (cur_cloc=
k =3D 30)
> [  102.599674] rtsx_pci 0000:c0:00.0: Switch card clock to 30MHz
> [  102.599679] rtsx_pci 0000:c0:00.0: Internal SSC clock: 30MHz (cur_cloc=
k =3D 30)
> [  102.599684] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_send_cmd_get_rsp: SD/M=
MC CMD 2, arg =3D 0x00000000
> [  102.600608] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[0] =3D 0x035344=
53
> [  102.600612] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[1] =3D 0x523032=
54
> [  102.600613] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[2] =3D 0x87bacf=
26
> [  102.600614] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[3] =3D 0xfe0189=
01
> [  102.600630] rtsx_pci 0000:c0:00.0: Switch card clock to 30MHz
> [  102.600631] rtsx_pci 0000:c0:00.0: Internal SSC clock: 30MHz (cur_cloc=
k =3D 30)
> [  102.600635] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_send_cmd_get_rsp: SD/M=
MC CMD 3, arg =3D 0x00000000
> [  102.601176] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[0] =3D 0xd55505=
00
> [  102.601195] rtsx_pci 0000:c0:00.0: Switch card clock to 30MHz
> [  102.601199] rtsx_pci 0000:c0:00.0: Internal SSC clock: 30MHz (cur_cloc=
k =3D 30)
> [  102.601205] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_send_cmd_get_rsp: SD/M=
MC CMD 7, arg =3D 0xd5550000
> [  102.601770] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[0] =3D 0x000007=
00
> [  102.601785] rtsx_pci 0000:c0:00.0: Switch card clock to 30MHz
> [  102.601786] rtsx_pci 0000:c0:00.0: Internal SSC clock: 30MHz (cur_cloc=
k =3D 30)
> [  102.601793] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
6, arg =3D 0x00fffff0
> [  102.604338] rtsx_pci 0000:c0:00.0: Switch card clock to 30MHz
> [  102.604340] rtsx_pci 0000:c0:00.0: Internal SSC clock: 30MHz (cur_cloc=
k =3D 30)
> [  102.604345] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_send_cmd_get_rsp: SD/M=
MC CMD 55, arg =3D 0xd5550000
> [  102.604887] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[0] =3D 0x000009=
20
> [  102.604893] rtsx_pci 0000:c0:00.0: Switch card clock to 30MHz
> [  102.604894] rtsx_pci 0000:c0:00.0: Internal SSC clock: 30MHz (cur_cloc=
k =3D 30)
> [  102.604899] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_send_cmd_get_rsp: SD/M=
MC CMD 6, arg =3D 0x00000002
> [  102.605462] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[0] =3D 0x000009=
20
> [  102.605480] rtsx_pci 0000:c0:00.0: Switch card clock to 30MHz
> [  102.605481] rtsx_pci 0000:c0:00.0: Internal SSC clock: 30MHz (cur_cloc=
k =3D 30)
> [  102.605486] rtsx_pci 0000:c0:00.0: Switch card clock to 30MHz
> [  102.605487] rtsx_pci 0000:c0:00.0: Internal SSC clock: 30MHz (cur_cloc=
k =3D 30)
> [  102.605493] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
6, arg =3D 0x80ff1fff
> [  102.608016] rtsx_pci 0000:c0:00.0: Switch card clock to 30MHz
> [  102.608019] rtsx_pci 0000:c0:00.0: Internal SSC clock: 30MHz (cur_cloc=
k =3D 30)
> [  102.608025] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
6, arg =3D 0x80fffff3
> [  102.612934] rtsx_pci 0000:c0:00.0: Switch card clock to 30MHz
> [  102.612936] rtsx_pci 0000:c0:00.0: Internal SSC clock: 30MHz (cur_cloc=
k =3D 30)
> [  102.612950] rtsx_pci 0000:c0:00.0: Switch card clock to 208MHz
> [  102.612951] rtsx_pci 0000:c0:00.0: Internal SSC clock: 208MHz (cur_clo=
ck =3D 30)
> [  102.612951] rtsx_pci 0000:c0:00.0: n =3D 206, div =3D 1
> [  102.612952] rtsx_pci 0000:c0:00.0: ssc_depth =3D 2
> [  102.613105] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(TX): samp=
le_point =3D 25
> [  102.613115] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 0
> [  102.613126] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.614718] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 1
> [  102.614732] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.614759] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 2
> [  102.614770] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.614796] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 3
> [  102.614815] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.614842] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 4
> [  102.614853] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.614879] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 5
> [  102.614890] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.614916] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 6
> [  102.614927] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.614952] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 7
> [  102.614963] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.614987] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 8
> [  102.614998] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.615024] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 9
> [  102.615035] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.615059] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 10
> [  102.615071] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.615095] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 11
> [  102.615107] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.615132] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 12
> [  102.615144] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.615172] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: rtsx_pci_send_cmd fail (e=
rr =3D -22)
> [  102.615178] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 13
> [  102.615187] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.615211] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: rtsx_pci_send_cmd fail (e=
rr =3D -22)
> [  102.615215] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 14
> [  102.615223] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.615235] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: rtsx_pci_send_cmd fail (e=
rr =3D -22)
> [  102.615350] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 15
> [  102.615358] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.615383] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: rtsx_pci_send_cmd fail (e=
rr =3D -22)
> [  102.615387] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 16
> [  102.615395] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.615419] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: rtsx_pci_send_cmd fail (e=
rr =3D -22)
> [  102.615424] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 17
> [  102.615432] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.615458] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: rtsx_pci_send_cmd fail (e=
rr =3D -22)
> [  102.615462] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 18
> [  102.615470] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.615495] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: rtsx_pci_send_cmd fail (e=
rr =3D -22)
> [  102.615499] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 19
> [  102.615507] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.615531] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 20
> [  102.615539] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.615562] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 21
> [  102.615570] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.615594] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 22
> [  102.615602] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.615625] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 23
> [  102.615633] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.615657] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 24
> [  102.615665] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.615689] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 25
> [  102.615697] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.615722] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 26
> [  102.615730] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.615754] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 27
> [  102.615762] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.615785] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 28
> [  102.615793] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.615817] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 29
> [  102.615825] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.615849] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 30
> [  102.615858] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.615890] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 31
> [  102.615907] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.615933] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 0
> [  102.615943] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.615968] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 1
> [  102.615977] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.616001] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 2
> [  102.616010] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.616034] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 3
> [  102.616042] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.616066] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 4
> [  102.616076] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.616100] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 5
> [  102.616109] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.616133] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 6
> [  102.616142] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.616168] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 7
> [  102.616180] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.616207] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 8
> [  102.616219] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.616244] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 9
> [  102.616257] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.616282] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 10
> [  102.616294] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.616319] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 11
> [  102.616331] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.616356] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 12
> [  102.616368] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.616395] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: rtsx_pci_send_cmd fail (e=
rr =3D -22)
> [  102.616402] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 13
> [  102.616413] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.616439] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: rtsx_pci_send_cmd fail (e=
rr =3D -22)
> [  102.616445] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 14
> [  102.616457] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.616471] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: rtsx_pci_send_cmd fail (e=
rr =3D -22)
> [  102.616580] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 15
> [  102.616592] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.616606] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: rtsx_pci_send_cmd fail (e=
rr =3D -22)
> [  102.616714] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 16
> [  102.616726] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.616753] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: rtsx_pci_send_cmd fail (e=
rr =3D -22)
> [  102.616758] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 17
> [  102.616770] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.616796] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: rtsx_pci_send_cmd fail (e=
rr =3D -22)
> [  102.616809] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 18
> [  102.616821] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.616848] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: rtsx_pci_send_cmd fail (e=
rr =3D -22)
> [  102.616854] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 19
> [  102.616866] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.616891] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 20
> [  102.616903] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.616928] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 21
> [  102.616940] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.616965] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 22
> [  102.616978] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.617003] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 23
> [  102.617015] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.617040] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 24
> [  102.617051] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.617076] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 25
> [  102.617088] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.617111] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 26
> [  102.617120] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.617143] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 27
> [  102.617152] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.617175] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 28
> [  102.617184] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.617207] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 29
> [  102.617216] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.617239] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 30
> [  102.617247] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.617271] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 31
> [  102.617280] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.617303] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 0
> [  102.617312] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.617335] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 1
> [  102.617343] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.617367] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 2
> [  102.617375] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.617398] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 3
> [  102.617407] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.617430] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 4
> [  102.617439] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.617462] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 5
> [  102.617471] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.617494] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 6
> [  102.617502] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.617525] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 7
> [  102.617534] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.617557] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 8
> [  102.617566] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.617589] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 9
> [  102.617598] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.617621] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 10
> [  102.617630] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.617653] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 11
> [  102.617662] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.617686] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 12
> [  102.617694] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.617719] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: rtsx_pci_send_cmd fail (e=
rr =3D -22)
> [  102.617723] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 13
> [  102.617732] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.617756] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: rtsx_pci_send_cmd fail (e=
rr =3D -22)
> [  102.617761] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 14
> [  102.617770] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.617782] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: rtsx_pci_send_cmd fail (e=
rr =3D -22)
> [  102.617889] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 15
> [  102.617898] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.617911] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: rtsx_pci_send_cmd fail (e=
rr =3D -22)
> [  102.618017] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 16
> [  102.618026] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.618051] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: rtsx_pci_send_cmd fail (e=
rr =3D -22)
> [  102.618056] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 17
> [  102.618064] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.618089] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: rtsx_pci_send_cmd fail (e=
rr =3D -22)
> [  102.618093] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 18
> [  102.618102] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.618127] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: rtsx_pci_send_cmd fail (e=
rr =3D -22)
> [  102.618132] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 19
> [  102.618140] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.618164] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 20
> [  102.618173] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.618196] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 21
> [  102.618205] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.618228] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 22
> [  102.618237] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.618260] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 23
> [  102.618268] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.618292] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 24
> [  102.618301] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.618324] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 25
> [  102.618333] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.618356] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 26
> [  102.618364] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.618388] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 27
> [  102.618397] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.618421] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 28
> [  102.618429] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.618454] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 29
> [  102.618463] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.618488] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 30
> [  102.618497] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.618520] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 31
> [  102.618529] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data: SD/MMC CMD =
19, arg =3D 0x00000000
> [  102.618552] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: RX raw_phase_map[0] =3D 0=
xfff80fff
> [  102.618554] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: RX raw_phase_map[1] =3D 0=
xfff80fff
> [  102.618555] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: RX raw_phase_map[2] =3D 0=
xfff80fff
> [  102.618556] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: RX phase_map =3D 0xfff80f=
ff
> [  102.618558] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: phase: [map:fff80fff] [ma=
xlen:25] [final:31]
> [  102.618559] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX): samp=
le_point =3D 31
> [  102.618579] rtsx_pci 0000:c0:00.0: Switch card clock to 208MHz
> [  102.618581] rtsx_pci 0000:c0:00.0: Internal SSC clock: 208MHz (cur_clo=
ck =3D 208)
> [  102.618586] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_write_data: SD/MMC CMD=
 49, arg =3D 0x10020800
> [  102.618587] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_send_cmd_get_rsp: SD/M=
MC CMD 49, arg =3D 0x10020800
> [  102.618598] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[0] =3D 0x000009=
00
> [  102.618754] rtsx_pci 0000:c0:00.0: Switch card clock to 208MHz
> [  102.618756] rtsx_pci 0000:c0:00.0: Internal SSC clock: 208MHz (cur_clo=
ck =3D 208)
> [  102.618759] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_send_cmd_get_rsp: SD/M=
MC CMD 13, arg =3D 0xd5550000
> [  102.618769] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[0] =3D 0x000009=
00
> [  102.618784] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: pre dma sg: 1
> [  102.618794] rtsx_pci 0000:c0:00.0: Switch card clock to 208MHz
> [  102.618795] rtsx_pci 0000:c0:00.0: Internal SSC clock: 208MHz (cur_clo=
ck =3D 208)
> [  102.618798] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_long_data: SD/MMC=
 CMD 18, arg =3D 0xc44607f8
> [  102.618800] rtsx_pci 0000:c0:00.0: DMA addr: 0x675e5000, Len: 0x1000
> [  102.619019] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_send_cmd_get_rsp: SD/M=
MC CMD 12, arg =3D 0x00000000
> [  102.619030] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[0] =3D 0x00000b=
00
> [  102.619066] rtsx_pci 0000:c0:00.0: Switch card clock to 208MHz
> [  102.619068] rtsx_pci 0000:c0:00.0: Internal SSC clock: 208MHz (cur_clo=
ck =3D 208)
> [  102.619074] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_send_cmd_get_rsp: SD/M=
MC CMD 13, arg =3D 0xd5550000
> [  102.619085] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[0] =3D 0x000009=
00
> [  102.619090] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sdmmc_get_cd: RTSX_BIPR =
=3D 0x00010000
> [  102.624418] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: pre dma sg: 17
> [  102.624445] rtsx_pci 0000:c0:00.0: Switch card clock to 208MHz
> [  102.624448] rtsx_pci 0000:c0:00.0: Internal SSC clock: 208MHz (cur_clo=
ck =3D 208)
>
> I've included a readout of sudo lspci -s c0:00.0 -xxxx below:
>
> c0:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. RTS525A =
PCI Express Card Reader (rev 01)
> 00: ec 10 5a 52 06 04 10 00 01 00 00 ff 10 00 00 00
> 10: 00 00 00 00 00 00 b0 b0 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 ec 10 5a 52
> 30: 00 00 00 00 80 00 00 00 00 00 00 00 ff 01 00 00
> 40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 80: 01 90 c3 f7 03 01 00 00 00 00 00 00 00 00 00 00
> 90: 05 b0 81 00 00 10 e0 fe 00 00 00 00 22 00 00 00
> a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> b0: 10 00 02 00 c2 8f 2c 01 30 20 19 00 12 7c 47 00
> c0: 42 01 12 10 00 00 00 00 00 00 00 00 00 00 00 00
> d0: 00 00 00 00 10 08 0c 00 00 04 00 00 06 00 00 00
> e0: 02 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 100: 01 00 82 14 00 00 00 00 00 00 40 00 30 20 46 00
> 110: 00 20 00 00 00 60 00 00 a0 00 00 00 00 00 00 00
> 120: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 130: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 140: 00 00 00 00 00 00 00 00 03 00 81 15 00 e0 4c 00
> 150: 01 00 00 00 00 00 00 00 18 00 01 16 01 10 01 10
> 160: 1e 00 01 00 1f 3c 31 00 0f 00 99 40 49 00 00 00
> 170: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 180: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 190: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 1a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 1b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 1c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 1d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 1e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 1f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 200: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 210: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 220: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 230: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 240: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 250: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 260: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 270: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 280: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 290: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 2a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 2b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 2c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 2d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 2e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 2f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 300: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 310: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 320: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 330: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 340: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 350: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 360: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 370: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 380: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 390: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 3a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 3b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 3c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 3d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 3e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 3f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 400: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 410: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 420: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 430: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 440: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 450: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 460: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 470: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 480: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 490: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 4a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 4b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 4c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 4d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 4e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 4f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 500: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 510: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 520: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 530: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 540: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 550: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 560: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 570: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 580: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 590: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 5a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 5b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 5c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 5d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 5e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 5f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 610: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 620: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 630: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 640: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 650: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 660: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 670: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 680: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 690: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 6a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 6b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 6c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 6d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 6e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 6f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 700: 68 00 38 01 ff ff ff ff 04 00 00 07 01 ff ff 5b
> 710: 20 01 01 00 00 00 00 00 00 00 01 00 80 02 00 00
> 720: 00 00 00 00 aa ff ff ee 11 7a f6 03 10 03 00 08
> 730: 80 00 01 00 ff 0f 01 00 40 00 01 00 01 00 00 00
> 740: 0f 00 00 00 00 00 00 00 20 40 20 40 04 40 20 00
> 750: 00 00 80 00 00 00 00 00 00 00 00 00 00 00 00 00
> 760: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 770: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 780: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 790: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 7a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 7b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 7c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 7d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 7e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 7f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 800: 00 00 00 00 00 00 00 00 00 00 00 00 ff 01 00 00
> 810: 94 b3 c8 24 75 1f 00 00 00 00 00 00 00 00 00 00
> 820: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 830: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 840: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 850: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 860: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 870: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 880: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 890: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 8a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 8b0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00 00
> 8c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 8d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 8e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 8f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 900: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 910: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 920: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 930: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 940: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 950: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 960: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 970: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 980: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 990: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 9a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 9b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 9c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 9d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 9e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 9f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> a00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> a10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> a20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> a30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> a40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> a50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> a60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> a70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> a80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> a90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> aa0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ab0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ac0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ad0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ae0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> af0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> b00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> b10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> b20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> b30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> b40: 01 00 00 00 d3 00 00 00 00 00 00 00 00 00 00 00
> b50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> b60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> b70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> b80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> b90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ba0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> bb0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> bc0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> bd0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> be0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> bf0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> c00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> c10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> c20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> c30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> c40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> c50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> c60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> c70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> c80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> c90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ca0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> cb0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> cc0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> cd0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ce0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> cf0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> d00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> d10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> d20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> d30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> d40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> d50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> d60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> d70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> d80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> d90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> da0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> db0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> dc0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> dd0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> de0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> df0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ea0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> eb0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ec0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ed0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ee0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ef0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> f10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> f20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> f30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> f40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> f50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> f60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> f70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> f90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> fa0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> fb0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> fc0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> fd0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> fe0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ff0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>
> deck@legion-go-2 ~> sudo cat /sys/kernel/debug/mmc0/ios
> clock:          208000000 Hz
> vdd:            21 (3.3 ~ 3.4 V)
> bus mode:       2 (push-pull)
> chip select:    0 (don't care)
> power mode:     2 (on)
> bus width:      2 (4 bits)
> timing spec:    6 (sd uhs SDR104)
> signal voltage: 1 (1.80 V)
> driver type:    0 (driver type B)
>
> As a workaround, not setting MMC_CAP_AGGRESSIVE_PM seems to resolve the i=
ssue:
>
> diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pc=
i_sdmmc.c
> index 1e5170435cf8..a7c7daf66d5c 100644
> --- a/drivers/mmc/host/rtsx_pci_sdmmc.c
> +++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
> @@ -1499,7 +1499,7 @@ static void realtek_init_host(struct realtek_pci_sd=
mmc *host)
>         mmc->caps =3D MMC_CAP_4_BIT_DATA | MMC_CAP_SD_HIGHSPEED |
>                 MMC_CAP_MMC_HIGHSPEED | MMC_CAP_BUS_WIDTH_TEST |
>                 MMC_CAP_UHS_SDR12 | MMC_CAP_UHS_SDR25;
> -       if (pcr->rtd3_en)
> +       if (pcr->rtd3_en && PCI_PID(pcr) !=3D PID_525A)
>                 mmc->caps =3D mmc->caps | MMC_CAP_AGGRESSIVE_PM;
>         mmc->caps2 =3D MMC_CAP2_NO_PRESCAN_POWERUP | MMC_CAP2_FULL_PWR_CY=
CLE |
>                 MMC_CAP2_NO_SDIO;
> --
> 2.52.0
>
> I think what's happening here is that RTS525A shuts off power to the card=
 reader when games are idle for 10 seconds or more, and then when the game =
goes to load new assets it has to go through the whole re-tuning process wh=
ich takes 1-2 seconds. The other brands of card readers I have keep the dev=
ice powered the whole time so they do not have this issue, and that's what =
untagging MMC_CAP_AGGRESSIVE_PM seems to mimic.

Right, MMC_CAP_AGGRESSIVE_PM does exactly what you think. If there are
an idle period of no requests for the SD card, the mmc core may decide
to power-off the card for those mmc host drivers that has set
MMC_CAP_AGGRESSIVE_PM. The idea is that we want to avoid wasting power
when the card is unused, which is typically important on some battery
driven devices.

The main problem however, is that we are lacking a common policy for
how to handle this generically for all eMMC/SD cards. Ideally it
should be independent of what mmc host drivers that is managing it,
but that's not the case.

That said, without changing the code you can use sysfs to either tweak
the idle-period or to simply prevent "runtime_suspend" (meaning
power-off) for the SD card.

For example, find the corresponding device for the mmc/sd card in
sysfs and do: echo on >.../power/control to prevent runtime suspend.

>
> Should I upstream the above as a quirk or is there further debugging I ca=
n assist with to find another workaround for the gameplay stutter? I've fou=
nd a couple other bugs with the card reader too but I will send out separat=
e threads to keep things organized.

Please post a formal patch, then let's discuss what to do about it.

>
> Thanks!
>
> Matt

Kind regards
Uffe
