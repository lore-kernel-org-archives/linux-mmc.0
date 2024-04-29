Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDC4DDB3
	for <linux-mmc@vger.kernel.org>; Mon, 29 Apr 2024 07:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714375381; cv=none; b=Yaz3tyCEmimh5HxgHEbifhGOP2rqvuT+jhA1FyaPQJDgDnBEFPg6zaWbKXsxI7BCArOjY45jTNspa8BdaAZFSMk0cR7ZVccXGl/aJvCNarjr0ga6MOSdA61gpcUL6FJrsz7fv7muKCoWJ23PQl32YEVmXcBz2ljLwZz+3UdYErk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714375381; c=relaxed/simple;
	bh=XUSZXM9WbeAA4411q4WzyPY9fDiUjV1/nlzMZCWAcpA=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=H/rcPer8klwn0kAMa5Dh2D+RPbw+7jEV7d6+pzO5Fxlif3pmHHAHxgVAQrjcNjOPEEaehIcM5oKLJ8QsQuIvKO26QdmtHpUqf8JAFbKpp6qMQvJHNApmaQVyEHV/qPkIpg4p4cwlnqIWB86zBANrK6erkp/g+Kain2Sz+QtIGX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=a+trCo22; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="a+trCo22"
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1714375377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uq+h/eRGftp+dhSgDaVAgpYPS/HfqH6qjIufK/LGGMg=;
	b=a+trCo22XAP9s/OCUUal6v95CWb3bOpwB6IVwB1d1PtYK7E/2zUxrsU+n3vuIV3Vd3Vnc1
	ikCytazDYgptpycexRdyVG5cQWR5yESuOq44LjDpJ4o0yftYuIiQLTwAjj5PQV1q7X8/zz
	ls3PkfwWTUnFqANsKUJramIoqVwsoQyT9ANaI835wCnvnHEU2IsHCjdxC4z6wYoN4n+rxr
	ePJrU3ONtQ3VZ0Omxdzfb4HsxzODSbfDKMa4jX84Sf4va5L7cGngJVhNELKpU5IOeEBmQy
	kyou+iyye683qmYWwoTqjUXwpU4PV4Ev+FQgzHpljSPp2TC5AwD/W3u0yZEGCA==
Date: Mon, 29 Apr 2024 09:22:57 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Yao Xiao <xiaokeqinhealth@126.com>
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, Avri Altman
 <avri.altman@wdc.com>
Subject: Re: [PATCH v3 1/1] mmc: core: increase the timeout period of the
 ACMD41 command.
In-Reply-To: <34190ce8-622c-4dd7-9686-1d53b1a343ce@126.com>
References: <20240429063847.162247-1-xiaokeqinhealth@126.com>
 <a8d9ed3ae3b6d884235594e31baa28ff@manjaro.org>
 <34190ce8-622c-4dd7-9686-1d53b1a343ce@126.com>
Message-ID: <84689df7c67c49e4626450f92e878f12@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-04-29 09:19, Yao Xiao wrote:
> On 2024/4/29 15:09, Dragan Simic wrote:
>> On 2024-04-29 08:38, Felix Qin wrote:
>>> Extensive testing has shown that some specific SD cards require an
>>> increased command timeout to be successfully initialized.
>>> 
>>> More info:
>>> Platform: Rockchip SoC + DW Multimedia host Controller
>>> SD card: Xvv microSD CMH34A17TMA12 (Made in Korea)
>>> Note: The SD card is custom-made by the customer in collaboration
>>> with the wafer foundry.
>>> 
>>> Signed-off-by: Felix Qin <xiaokeqinhealth@126.com>
>>> Acked-by: Avri Altman <avri.altman@wdc.com>
>>> Reviewed-by: Dragan Simic <dsimic@manjaro.org>
>> 
>> Huh, the v3 looks nowhere like the v2, so please consider
>> my Reviewed-by tag revoked until I get some time to check what
>> actually happened to the patch.
> 
> I apologize for the inconvenience caused, and I will resend the patch.

No worries.  I'll go through the v3 and the associated Ulf's
patch a bit later.

>>> ---
>>> v2: Add more info
>>> v3: Based on the __mmc_poll_for_busy API for modification
>>> ---
>>>  drivers/mmc/core/sd_ops.c | 7 ++++++-
>>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>> 
>>> diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
>>> index 3ce1ff336826..a1c028303ba7 100644
>>> --- a/drivers/mmc/core/sd_ops.c
>>> +++ b/drivers/mmc/core/sd_ops.c
>>> @@ -19,8 +19,13 @@
>>>  #include "sd_ops.h"
>>>  #include "mmc_ops.h"
>>> 
>>> +/*
>>> + * Extensive testing has shown that some specific SD cards
>>> + * require an increased command timeout to be successfully
>>> + * initialized.
>>> + */
>>>  #define SD_APP_OP_COND_PERIOD_US    (10 * 1000) /* 10ms */
>>> -#define SD_APP_OP_COND_TIMEOUT_MS    1000 /* 1s */
>>> +#define SD_APP_OP_COND_TIMEOUT_MS    2000 /* 2s */
>>> 
>>>  struct sd_app_op_cond_busy_data {
>>>      struct mmc_host *host;
