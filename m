Received: from mail-m1973171.qiye.163.com (mail-m1973171.qiye.163.com [220.197.31.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50C1336EE5;
	Fri, 16 Jan 2026 14:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768573498; cv=none; b=Vq9X+sWtoPkTFBQzqO15Kelv4SfxNcf21yfNYRPztXf4xGc2r6Tx3fSQUViki5ST1Xm+68lcdt/CIVlF8NR/6mDGRXSEqhW/3Je7XIjSPI06jHTxZxhaIQj/i22CRkCc/R6fHcuhklD5A7irdYPXCKtveC0SAky0cHyFGmyPp0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768573498; c=relaxed/simple;
	bh=Q9+N2kdQwF676ptVfBkQ+HfHccfecqxsnM1b7Iz4UOw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XzOERO+EHwVGntucNJMBkmknZ4qop8B3YlYAXfcA4Jx6SbOEmTDFL/pWzICtmSI1evK8Jv0L7QdjPO7DJ7Fy52yvBWfi2FXn+DZEyNzReqgV2R7wtebwPyV7QObsefScS+FrsOlNdDl0/NMPGOa7nQwCK/dRufaAuAEH1xGQZUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=Sb+rY8nk; arc=none smtp.client-ip=220.197.31.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="Sb+rY8nk"
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 30ef46e5a;
	Fri, 16 Jan 2026 22:24:40 +0800 (GMT+08:00)
Message-ID: <0c6b4cc1-ce99-4d59-a470-b07dec763e8b@rock-chips.com>
Date: Fri, 16 Jan 2026 22:24:38 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, linux-rockchip@lists.infradead.org,
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 FUKAUMI Naoki <naoki@radxa.com>,
 Marco Schirrmeister <mschirrmeister@gmail.com>,
 John Clark <inindev@gmail.com>, Tianling Shen <cnsztl@gmail.com>,
 Detlev Casanova <detlev.casanova@collabora.com>
Subject: Re: (subset) [PATCH v4 0/5] Fix sd card support for RK3576 platform
To: Heiko Stuebner <heiko@sntech.de>, Ulf Hansson <ulf.hansson@linaro.org>
References: <1768524932-163929-1-git-send-email-shawn.lin@rock-chips.com>
 <176857210194.116631.11189192556414524729.b4-ty@sntech.de>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <176857210194.116631.11189192556414524729.b4-ty@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9bc731aea209cckunma7c09507737a3c
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUgaQlZJSk8dHktIHUlPTUNWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=Sb+rY8nk8Ejra1PEfQhzgPPEi7zoTmfua3u4T3ZLfEzIZimP+iLjTUczs2Q/u7ML0JsvPRmfptEh9QF1QcdaERr6e4Pet/umJumuiaYX05kjmGuSKXIwx40j18+2imsv+HoIJUjyOk60TKCZt5Fr0ar2XTAgETW2Lv6Kg8CaUHI=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=xpJGynjXo2jFqQ092nLYCB2ielun+b6JZDAUGmUfEc4=;
	h=date:mime-version:subject:message-id:from;


在 2026/01/16 星期五 22:04, Heiko Stuebner 写道:
> 
> On Fri, 16 Jan 2026 08:55:27 +0800, Shawn Lin wrote:
>> Marco reported a problem[1] for his FriendlyElec NanoPi R76S board. The problem
>> is becuase after runtime suspend, the associated power domain is powered off, which
>> resets the registers including power control bit, card detection logic and internal
>> phase registers. This leads to three problems need to be solved.
>>
>> 1. hot-plug broken:
>>
>> [...]
> 
> Applied, thanks!
> 
> [1/5] soc: rockchip: grf: Fix wrong RK3576_IOCGRF_MISC_CON definition
>        commit: 3cdc30c42d4a87444f6c7afbefd6a9381c4caa27
> [2/5] soc: rockchip: grf: Support multiple grf to be handled
>        commit: 75fb63ae031211e9264ac888fabc2ca9cd3fcccf
> [4/5] arm64: dts: rockchip: Fix SD card support for RK3576 EVB1
>        commit: 7226664bf952c4cfddccd74b154a7d994608d153
> [5/5] arm64: dts: rockchip: Fix SD card support for RK3576 Nanopi R76s
>        commit: a9c1acebfe0484343a443d082e039ca77186ed22
> 
> I've queued them for 6.20 because I'd like them to marinate a bit longer
> due to the size of the changes, but added Cc-stable tags so that they
> then can make their way into stable kernels.
> 

Sure, thanks Heiko.

> Depending if MMC maintainers see patch3, you might want to resend it
> individually at some point.
> 
> 
> Best regards,

