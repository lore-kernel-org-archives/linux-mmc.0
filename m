Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD243313550;
	Mon, 26 Jan 2026 12:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769429330; cv=none; b=BsfwmYWIjJDqN5FRsx2jxKgaFKtiZzzngunRxBeOY7YAIc4hFQidZFm8mQtQMLV/08dTRYzpmsGaFT5pdDqHoYK3jRjbpqiqbXg4aoFvYwodXiD4pHViBR+CzP7rjo6j0uw0O682zDPiHCPt1gD08m4kYrxav2eLEYv9iDWl6qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769429330; c=relaxed/simple;
	bh=BuU1XdUnu9/+Zs3Udkm0xIjf8J3hHXLRYzMRS57s/aQ=;
	h=Message-ID:Date:From:MIME-Version:To:CC:Subject:References:
	 In-Reply-To:Content-Type; b=lmMB/X4erqv24HUB4Arxny37xRyb6K0+vQ7yAL+zVAM4lPcj6O3FCUKmmhq8xxaCcB1RhTm/UuJqbX78RjiU9L4YUm+XnyiM2i7v/Ziubu4YeF9ge1BqjcKbcK25aIILWZkFMXb200iMaDlml4/QteeJlZDocIWPWQatCWPc93I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=sLcuE2pr; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="sLcuE2pr"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=xAe6f3N2n6bbqsz2DCjAXYNczPYRCiPzRDAZXc0IYt8=;
	b=sLcuE2prG4LYTvO7k6nsDzHaUg17oytddjyh0XMcu27j0O5VV+gybAFvXyBmghtRUzSF/aa/M
	CoiF2NP3bZ9FHsiskyrZepMk6tAqgQcBiCPtiWJeo+XjAYdhbk9w3RAx0B5LPSNU9ZFZRTyByFr
	Xbb/693FoRcaj7TV3O6xbME=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4f06g00Kytz1prKP;
	Mon, 26 Jan 2026 20:05:16 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id C7FCC404AD;
	Mon, 26 Jan 2026 20:08:44 +0800 (CST)
Received: from kwepemq100003.china.huawei.com (7.202.195.72) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 26 Jan 2026 20:08:44 +0800
Received: from [10.67.112.52] (10.67.112.52) by kwepemq100003.china.huawei.com
 (7.202.195.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 26 Jan
 2026 20:08:44 +0800
Message-ID: <6977594B.4020902@hisilicon.com>
Date: Mon, 26 Jan 2026 20:08:43 +0800
From: Wei Xu <xuwei5@hisilicon.com>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>
CC: <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Jaehoon Chung
	<jh80.chung@samsung.com>, <xuwei5@hisilicon.com>
Subject: Re: [PATCH v2 1/3] arm64: dts: hisilicon: hikey960/970: Convert to
 use standard mmc alias
References: <1769171049-74327-1-git-send-email-shawn.lin@rock-chips.com> <1769171049-74327-2-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1769171049-74327-2-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemq100003.china.huawei.com (7.202.195.72)

Hi Shawn,

On 2026/1/23 20:24, Shawn Lin wrote:
> Convert the long-deprecated mshc alias to standard mmc alias.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

LGTM,

Reviewed-by: Wei Xu <xuwei5@hisilicon.com>

Thanks!
Best Regards,
Wei

> ---
> 
> Changes in v2: None
> 
>  arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts | 4 ++--
>  arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> index ed84ab9..c6056a8 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> @@ -20,8 +20,8 @@
>  	compatible = "hisilicon,hi3660-hikey960", "hisilicon,hi3660";
>  
>  	aliases {
> -		mshc1 = &dwmmc1;
> -		mshc2 = &dwmmc2;
> +		mmc1 = &dwmmc1;
> +		mmc2 = &dwmmc2;
>  		serial0 = &uart0;
>  		serial1 = &uart1;
>  		serial2 = &uart2;
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts b/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
> index 7c32f5f..65764b3 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
> +++ b/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
> @@ -19,8 +19,8 @@
>  	compatible = "hisilicon,hi3670-hikey970", "hisilicon,hi3670";
>  
>  	aliases {
> -		mshc1 = &dwmmc1;
> -		mshc2 = &dwmmc2;
> +		mmc1 = &dwmmc1;
> +		mmc2 = &dwmmc2;
>  		serial0 = &uart0;
>  		serial1 = &uart1;
>  		serial2 = &uart2;
> 
