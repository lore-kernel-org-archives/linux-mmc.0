Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071AC2E0B4E;
	Sat, 13 Sep 2025 04:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757739503; cv=none; b=Mguot7/VN0nh7bRg5R2Fu3TC2vBDF9dhDGITYxa1M98lNRfGQ1TnQWskiZP1pGDk6kXk7gnFN/oZtLdrtEqHVEki9QhrnR4r9kqpg5kLqvip7kVu3NSO7fgIKZyV6TqG/ymEboiKh7VVrQq86cwM8eGbr2aqO3vkdGJypcbvDrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757739503; c=relaxed/simple;
	bh=QKdWbEhXOdjq4saRav6ZDCQr2csgoPOIuQoBxIZ+L5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W+G65pLj4t9agstZ3rALHzjlJKmWO6wg9wO+GEf1oWKyE9LOy9TPAqaJF2MHawqrLoW36fKI0smN6TzvAihJsGraLNDESxY674CGrLvpSmkMy4QBY4sireQ9lYX7MPsuirZZqela3E+LB9zGdirQ14HsGu5RiTzuCisCaj93sjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [153.35.206.47])
	by gateway (Coremail) with SMTP id _____8BxE9Dd+cRoT_EJAA--.20814S3;
	Sat, 13 Sep 2025 12:58:05 +0800 (CST)
Received: from [192.168.86.5] (unknown [153.35.206.47])
	by front1 (Coremail) with SMTP id qMiowJCxrsPb+cRo2Q2SAA--.53349S2;
	Sat, 13 Sep 2025 12:58:04 +0800 (CST)
Message-ID: <1f09322b-6bc5-437b-88b5-dec306748d80@loongson.cn>
Date: Sat, 13 Sep 2025 12:58:00 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] mmc: remove COMPILE_TEST from MMC_LOONGSON2
To: Mikko Rapeli <mikko.rapeli@linaro.org>, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
 victor.shih@genesyslogic.com.tw, ben.chuang@genesyslogic.com.tw,
 geert+renesas@glider.be, angelogioacchino.delregno@collabora.com,
 dlan@gentoo.org, arnd@arndb.de, zhoubb.aaron@gmail.com
References: <20250912142253.2843018-1-mikko.rapeli@linaro.org>
 <20250912142253.2843018-4-mikko.rapeli@linaro.org>
Content-Language: en-US
From: Binbin Zhou <zhoubinbin@loongson.cn>
In-Reply-To: <20250912142253.2843018-4-mikko.rapeli@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qMiowJCxrsPb+cRo2Q2SAA--.53349S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAQEECGjDtiYabAAAsB
X-Coremail-Antispam: 1Uk129KBj9xXoWrur1UtryDWryUZFyrKF47KFX_yoWDGFXEga
	yjgwn7Gr12kryxZ3W0qF1kZry3ta1kWr1UXryrKrnxua43JFnYv3W3urn0qw13ua1UuFW2
	9rWS9r1Svw48AosvyTuYvTs0mTUanT9S1TB71UUUUbUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbTkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0
	oVCq3wAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa02
	0Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_Wryl
	Yx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCY1x
	0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCF
	I7km07C267AKxVWUtVW8ZwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r
	106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AK
	xVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7
	xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_
	Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jo_M-UUUUU=

Hi Mikko:

Thanks for your patch.

On 2025/9/12 22:22, Mikko Rapeli wrote:
> It fails to link due to undeclared dependency
> to regmap which is not enabled for COMPILE_TEST:
> 
> ERROR: modpost: "__devm_regmap_init_mmio_clk"
> [drivers/mmc/host/loongson2-mmc.ko] undefined!
> 
> Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
> ---
>   drivers/mmc/host/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 2db46291ae442..e2d9a7cf9f855 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -1113,7 +1113,7 @@ config MMC_OWL
>   
>   config MMC_LOONGSON2
>   	tristate "Loongson-2K SD/SDIO/eMMC Host Interface support"
> -	depends on LOONGARCH || COMPILE_TEST
> +	depends on LOONGARCH

How about add `select REGMAP_MMIO` instead.

>   	depends on HAS_DMA
>   	help
>   	  This selects support for the SD/SDIO/eMMC Host Controller on

Thanks.
Binbin

