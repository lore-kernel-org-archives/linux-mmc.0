Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67CD2192EC;
	Mon, 23 Jun 2025 09:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750672625; cv=none; b=Sre3uj8MT7vIfTCPVdb6YNYvKYXDgYUlYwYZ4s8UT0Uwy+fXKUpLVCTiHCAHoTdfjceZaslnbUm2zyzA6ApBC1tFZxFW75nKPoUita/CVbRbieAkg+IgEW3ihJA0TLI8t1Iqplu9rQnad02uBg0pXifgf4o+pIGaOkXbtVoWNmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750672625; c=relaxed/simple;
	bh=U7XIW8hy4Y2hgCabhIOAkmUThrnJnj5hGEjrn7p2UNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oibKyIY7C6LXjRP07upzNj8T9wZiIejFPYaUmlIErZiUOgCgKB59gWu2/sXEV2BIfNrP/MJtddkcr46yj5lhyyAQcSgGeMcWWHuVjFIE+trLVudTynoVtJvVFb/d3NK7mz87Q7dCG5CtbDDOsVtNr4MLVPMNHyIp0JkQOZMR5ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=BkyQmY62; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="BkyQmY62"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1750672621;
	bh=U7XIW8hy4Y2hgCabhIOAkmUThrnJnj5hGEjrn7p2UNc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BkyQmY627azdUczLx7oZc3igZbN0MsdTraBo/0pVjbZuOdw5mpSQ4zlCh2Gxb7qs3
	 ShQVrFvbYRj2O9Gfm5SZk2JNDiv+hQrEFCCFFM8oGfcSjTvg6gJJ2wK+1fl11YUu6F
	 /R5+C/eHWX6uaDf26ohy4DBQPaWOhfx7LOApKDQyDWcm2Y/AgAUu/6OeX1fP8oz+Pr
	 8lFjROw5L08Q+p8GnF68Qxygy1v/YcMCibXVC4fM288GhOKa7jNOFjku2lgKr79erh
	 uf2JhZHGniRMqAJOn82nwe0QskP9Grnn47MpisOqJKX79T36P0ay195xdrZZeTuUsf
	 gqXvREbwpkoUw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B34E717E0CE6;
	Mon, 23 Jun 2025 11:57:00 +0200 (CEST)
Message-ID: <b0bd3ac2-7698-40a4-966f-25a06a15c9ff@collabora.com>
Date: Mon, 23 Jun 2025 11:57:00 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] mmc: mtk-sd: disable auto CMD23 support for mt7620
To: Shiji Yang <yangshiji66@outlook.com>, linux-mmc@vger.kernel.org,
 Chaotian Jing <chaotian.jing@mediatek.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <OSBPR01MB16708176FE57F691359D0943BC7DA@OSBPR01MB1670.jpnprd01.prod.outlook.com>
 <OSBPR01MB16701142441CAA0F2D12A843BC7DA@OSBPR01MB1670.jpnprd01.prod.outlook.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <OSBPR01MB16701142441CAA0F2D12A843BC7DA@OSBPR01MB1670.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 19/06/25 07:35, Shiji Yang ha scritto:
> MT7628 ProgrammingGuide indicates that the host controller version
> 3.0 and later support auto CMD23 function. However, it doesn't
> define the SD command register BIT[29](Auto CMD23 enable bit). I
> guess the legacy MIPS MT762x series SoCs don't support this feature
> at all. The experiment on JDCloud RE-SP-01B(MT7621 + 128 GiB EMMC)
> shows that disabling auto CMD23 can fix the following IO errors:
> 
> [  143.344604] mtk-msdc 1e130000.mmc: msdc_track_cmd_data: cmd=6 arg=03B30101; host->error=0x00000002
> [  143.353661] mtk-msdc 1e130000.mmc: msdc_track_cmd_data: cmd=6 arg=03B30101; host->error=0x00000002
> [  143.362662] mtk-msdc 1e130000.mmc: msdc_track_cmd_data: cmd=6 arg=03B30101; host->error=0x00000002
> [  143.371684] mtk-msdc 1e130000.mmc: msdc_track_cmd_data: cmd=6 arg=03B30101; host->error=0x00000002
> [  143.380684] I/O error, dev mmcblk0boot0, sector 0 op 0x0:(READ) flags 0x80700 phys_seg 4 prio class 0
> [  143.390414] mtk-msdc 1e130000.mmc: msdc_track_cmd_data: cmd=6 arg=03B30101; host->error=0x00000002
> [  143.399468] mtk-msdc 1e130000.mmc: msdc_track_cmd_data: cmd=6 arg=03B30101; host->error=0x00000002
> [  143.408516] mtk-msdc 1e130000.mmc: msdc_track_cmd_data: cmd=6 arg=03B30101; host->error=0x00000002
> [  143.417556] mtk-msdc 1e130000.mmc: msdc_track_cmd_data: cmd=6 arg=03B30101; host->error=0x00000002
> [  143.426590] I/O error, dev mmcblk0boot0, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
> [  143.435585] Buffer I/O error on dev mmcblk0boot0, logical block 0, async page read
> 
> Signed-off-by: Shiji Yang <yangshiji66@outlook.com>

Chaotian, could you please confirm that MT7628 does not support AutoCMD23?

Thanks,
Angelo

