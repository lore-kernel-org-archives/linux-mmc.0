Received: from mail-m49208.qiye.163.com (mail-m49208.qiye.163.com [45.254.49.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B062D94A4
	for <linux-mmc@vger.kernel.org>; Tue, 25 Nov 2025 07:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764055694; cv=none; b=Wv7Hdb8fuFbYvi8MwMu8DcZFGMgewu3yqKcgHVsf4/0k2s9YIaL3eGhUI4DD5Ng7ZiFyxp2Gqq0g2CwYA1k7A+RFzENjARf89qxKvZ9KZ5SyTShz9QC2C0H0XqW7bLqUnbRCE0i4I3CkZlEwFDBT2r0Me4LmaCzMOoQW2PtJB0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764055694; c=relaxed/simple;
	bh=ePobKDawaCYaIZnnclJMPXbpuBG4iwo/PWP2nPUrfzs=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=me8VwsIiNmuCMWggJZI1CqPZu+SL5e1gKOQUII4D+umvcqH8CPZyU/DSaBQuOD+xlBCCPRMbH6PvrKX05LnMYAH0jlP6D3QftwzKu/JF2F+wBGQlJyIyejm9odvrvbGLghqboxHM0SK7v78J/96YKU8FEd0yTpwnkDxkO8SOWD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=dvqdj2Dd; arc=none smtp.client-ip=45.254.49.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="dvqdj2Dd"
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2acd68ee2;
	Tue, 25 Nov 2025 15:27:59 +0800 (GMT+08:00)
Message-ID: <fecd4ac6-c872-4ab8-a7b7-c27505ed4639@rock-chips.com>
Date: Tue, 25 Nov 2025 15:27:58 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Ulf Hansson <ulf.hansson@linaro.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH 2/2] mmc: core: Add quirk for broken manufacturing date
To: Avri Altman <Avri.Altman@sandisk.com>
References: <20251122070442.111690-1-avri.altman@sandisk.com>
 <20251122070442.111690-3-avri.altman@sandisk.com>
 <c0eefc16-9e85-4ca8-a32e-28878895c65c@rock-chips.com>
 <DS1PR16MB6753C1E4EB804DA77041DAADE5D1A@DS1PR16MB6753.namprd16.prod.outlook.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <DS1PR16MB6753C1E4EB804DA77041DAADE5D1A@DS1PR16MB6753.namprd16.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9ab9e9821809cckunmce2e146f4702ab
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGRoeTlZMHx1IGEIeGUhMSRpWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=dvqdj2DdhFUjTFuZ2v7qBY9itdgB9mlrykk55P9HsqEnFPGschYnBU/Hy5VFasoVHw7VCyJ+/P1Qymdu2q30Vq4HTY2YLi68CaQd3EJVcWSquC5jw1wVxiF6ry9ZOaCocIJZ79ah46ba6rJkTSQz2QgELrkJcMYMtacoqrfRezg=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=hXFpp/1LXlSSMuoGTAAsMhx4QcBZEvHMWGLJEath9cA=;
	h=date:mime-version:subject:message-id:from;

在 2025/11/25 星期二 15:07, Avri Altman 写道:
>> Hi Avri,
>>
>> 在 2025/11/22 星期六 15:04, Avri Altman 写道:
>>> Some eMMC vendors need to report manufacturing dates beyond 2025 but
>>> are reluctant to update the EXT_CSD revision from 8 to 9. Changing the
>>> EXT_CSD revision is a firmware modification that would force these
>>> vendors to re-pass an exhaustive and costly set of Approved Vendor
>>> List
>>> (AVL) qualifications with their customers.
>>>
>>
>> Ack, I fully understand this situation, as we also need re-certificate eMMC chip on
>> our AVL if vendor renew the firmware.
>>
>>> To avoid this re-qualification process, a workaround is needed. This
>>> patch introduces a temporary quirk that re-purposes the year codes
>>> corresponding to 2010, 2011, and 2012 to represent the years 2026,
>>> 2027, and 2028, respectively. This solution is only valid for this
>>> three-year period.
>>>
>>> After 2028, vendors must update their firmware to set EXT_CSD_REV=9 to
>>> continue reporting the correct manufacturing date in compliance with
>>> the JEDEC standard.
>>>
>>> The `MMC_QUIRK_BROKEN_MDT` is introduced and enabled for all Sandisk
>>> devices to handle this behavior.
>>
>>
>> Would other vendors need this quirk but with different policy/ adjustment?
> What do have in mind?

Is it possible to add something like below?

MMC_FIXUP(CID_NAME_ANY, CID_MANFID_SANDISK, CID_OEMID_ANY,
mdt_quirk_sandisk, 0),

static inline void __maybe_unused mdt_quirk_sandisk(struct mmc_card *card)
{
if (card->cid.year >= 2010 && card->cid.year <= 2012)
	card->cid.year += 16;
}



> 
> Thanks,
> Avri

