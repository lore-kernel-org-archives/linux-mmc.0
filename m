Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9701A5B91;
	Mon, 17 Feb 2025 12:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739793732; cv=none; b=C765Z9b1eQ27cTPYy0NWCIbTp2vaIlX8X84C1/Et8rk6cZ8WVpASiBwxuIoVNEuUrGVzoAPDZYsIwhHio2pQvPY9qCRoWkPjE3Scm2atI2x1NIYXTf+9DmykfJ+MTGLrmr9liKBbORKWx/Zk/kITo+kNWjpfGfSzwuLhIEeIy3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739793732; c=relaxed/simple;
	bh=3wNmsiQetCfVtGLShZAaVYcM3oxhWvUxulLeuyilSto=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SYPbRUu9NuF1N3oH62SHt3EOV9FW68up+7g8oLuS6OluSyegD9SdgIBfb+Ek2fy9Vqw/klpkx0lLwmxEVyAI2R2sfEsZ6PzgDOcTE8kYGKO0wznl6K9lLEDtWRP8/uEn3Hha8fwYBNmVdlWNHyKu1a773ruNeScDHcq7lmNZLjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 534711692;
	Mon, 17 Feb 2025 04:02:28 -0800 (PST)
Received: from [10.1.35.42] (e127648.arm.com [10.1.35.42])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8DE173F5A1;
	Mon, 17 Feb 2025 04:02:06 -0800 (PST)
Message-ID: <3e79d92a-6ec9-4c7a-a836-1306678c2bef@arm.com>
Date: Mon, 17 Feb 2025 12:02:04 +0000
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: improve imx8mq emmc/sd read
 performance
To: Lucas Stach <l.stach@pengutronix.de>, ziniu.wang_1@nxp.com,
 adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc: imx@lists.linux.dev, s32@nxp.com, shawnguo@kernel.org,
 s.hauer@pengutronix.de, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, haibo.chen@nxp.com, kernel@pengutronix.de,
 festevam@gmail.com, linux-arm-kernel@lists.infradead.org
References: <20250217110623.2383142-1-ziniu.wang_1@nxp.com>
 <ab721b4a96495516f5149e91f3e4764014e39ba6.camel@pengutronix.de>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <ab721b4a96495516f5149e91f3e4764014e39ba6.camel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/17/25 11:58, Lucas Stach wrote:
> Hi Luke,
> 
> Am Montag, dem 17.02.2025 um 19:06 +0800 schrieb ziniu.wang_1@nxp.com:
>> From: Luke Wang <ziniu.wang_1@nxp.com>
>>
>> Compared with kernel 6.1, imx8mq eMMC/SD read performance drops by about
>> 30% with kernel 6.6.
>>
>> The eMMC/SD read thread will be put to sleep until the hardware completes
>> data transfer. Normally, the read thread will be woken up immediately
>> when the data transfer is completed. However, due to a known ic bug, if
>> imx8mq is in cpuidle, it will take a long time (about 500us) to exit
>> cpuidle. As a result, the read thread cannot immediately read the next
>> data block, affecting the read performance.
>>
> Is this really a problem with the upstream kernel? i.MX8MQ upstream
> does not use the deeper PSCI idle states, but only uses WFI, so I doubt
> that upstream is affected by this issue.
> 
> Regards,
> Lucas

Furthermore if that were to be the case the correct solution would probably
to have that reflected in the dts, too?

