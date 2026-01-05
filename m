Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413B321CC51;
	Mon,  5 Jan 2026 04:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767588795; cv=none; b=H/WqPvWNba6BljIdH/jk2ANep56bGBSFzrxRZbb/HlsqjFU20Q4dRJAYPVMMUDcK4nrOS5PAIyotPUxcGVGaUIAQLqOnhbZXSc117iqPnHJO4MqOeSDpacSjjIysqkCRuZwaU73h9D2FURBje8RZLtTKwgO5OGOaCnDGtz219a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767588795; c=relaxed/simple;
	bh=yELbQwbnsgLzpwN3/GLDAPfL2+/UdcA9MQlB79sWNmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M9MzIedF/ZvlBYgMdwHvRVC9E+n5jAn6USo1YaNE/rjzqvivYfgPScFFyv88x9EVbu2d5japBIZhOkMHYvIqfc7n3IuwNslVHKLKKxhjeBdgsLXsZUp+VIObheiQ2YjJYWA6FV1qYC51eKzPBYQ3/aj4TBAxvXcgBSD37HIyHUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CVe2VY7h; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CVe2VY7h"
Message-ID: <47ed09fc-047b-4f98-8df3-d11d17678c57@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767588789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2FxWmAYI6bk+Ozd5aawBahhQ5bfPCeXfaHsE+67bqr8=;
	b=CVe2VY7hJ2eWh/kMO3N4lFEmV6saA5nDuiPBd8ANPiF0mrsTOiETWU2NOg7aw2K3RKkYbH
	XrkgsI3e8y49Y4YF30tlEUYb8I9l/Wn7UiJuUfTH3+Yeu44oOw76VUfc0c9gzh1KwVL7mw
	jgh6wm0q/6FT56xu8fONVcFKEqyVW04=
Date: Sun, 4 Jan 2026 20:53:03 -0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [BUG] - Short freezes in gameplay due to MMC_CAP_AGGRESSIVE_PM on
 RTS525A card reader
To: Ricky WU <ricky_wu@realtek.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
References: <ff9a7c20-f465-4afa-bf29-708d4a52974a@linux.dev>
 <CAPDyKFrGpvjONrDmnNZXv+SME_NCNv-LK8J-Vo88RSz1fuD7rg@mail.gmail.com>
 <787171c6-0b9c-400b-8a95-b331b58e284c@linux.dev>
 <4777aabd-bc9e-4904-9444-892393aecb15@linux.dev>
 <9e362d5fa2604fb0848ea28866dc45fc@realtek.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Matthew Schwartz <matthew.schwartz@linux.dev>
In-Reply-To: <9e362d5fa2604fb0848ea28866dc45fc@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/4/26 7:58 PM, Ricky WU wrote:
>> On 1/3/26 11:52 AM, Matthew Schwartz wrote:
>>> On 1/3/26 3:37 AM, Ulf Hansson wrote:
>>>> On Wed, 24 Dec 2025 at 22:01, Matthew Schwartz
>>>> <matthew.schwartz@linux.dev> wrote:
>>>>>
>>>>> Hello,
>>>>>
>>>>> I have several handheld devices that have a Realtek Semiconductor Co., Ltd.
>> RTS525A PCI Express Card Reader and I am running into an issue on all of them
>> when I try to play games off of my SanDisk Extreme PRO Micro SD cards.
>>>>>
>>>>> I have two SD cards, a 1TB and a 2TB model, and while playing games off
>> of either one there are frequent freezes in gameplay. When this happens, the
>> kernel has some mmc and rtsx errors:
>>>>>
>>>>> [   41.348311] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_send_cmd_get_rsp:
>> SD/MMC CMD 13, arg = 0xd5550000
>>>>> [   41.354004] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[0] =
>> 0x00000900
>>>>> [   41.354020] rtsx_pci 0000:c0:00.0: Switch card clock to 208MHz
>>>>> [   41.354021] rtsx_pci 0000:c0:00.0: Internal SSC clock: 208MHz
>> (cur_clock = 208)
>>>>> [   41.354026] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 48, arg = 0x08000200
>>>>> [   41.354235] rtsx_pci 0000:c0:00.0: Switch card clock to 30MHz
>>>>> [   41.354236] rtsx_pci 0000:c0:00.0: Internal SSC clock: 30MHz
>> (cur_clock = 208)
>>>>> [   41.354237] rtsx_pci 0000:c0:00.0: n = 118, div = 3
>>>>> [   41.354237] rtsx_pci 0000:c0:00.0: ssc_depth = 1
>>>>> [   41.601291] rtsx_pci 0000:c0:00.0: --> rtsx_pci_runtime_idle
>>>>> [   51.521666] rtsx_pci 0000:c0:00.0: --> rtsx_pci_runtime_suspend
>>>>> [  101.898966] rtsx_pci 0000:c0:00.0: --> rtsx_pci_runtime_resume
>>>>> [  101.899052] rtsx_pci 0000:c0:00.0: RTSX_BIER: 0x36400000
>>>>> [  101.910028] rtsx_pci 0000:c0:00.0: Power OFF efuse!
>>>>> [  102.025901] rtsx_pci 0000:c0:00.0: Switch card clock to 30MHz
>>>>> [  102.025907] rtsx_pci 0000:c0:00.0: Internal SSC clock: 30MHz
>> (cur_clock = 30)
>>>>> [  102.025911] rtsx_pci_sdmmc rtsx_pci_sdmmc.0:
>> sdmmc_switch_voltage: signal_voltage = 0
>>>>> [  102.031892] rtsx_pci 0000:c0:00.0: Switch card clock to 30MHz
>>>>> [  102.031900] rtsx_pci 0000:c0:00.0: Internal SSC clock: 30MHz
>> (cur_clock = 30)
>>>>> [  102.037892] rtsx_pci 0000:c0:00.0: Switch card clock to 30MHz
>>>>> [  102.037899] rtsx_pci 0000:c0:00.0: Internal SSC clock: 30MHz
>> (cur_clock = 30)
>>>>> [  102.039168] rtsx_pci 0000:c0:00.0: Switch card clock to 30MHz
>>>>> [  102.039172] rtsx_pci 0000:c0:00.0: Internal SSC clock: 30MHz
>> (cur_clock = 30)
>>>>> [  102.039177] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_send_cmd_get_rsp:
>> SD/MMC CMD 0, arg = 0x00000000
>>>>> [  102.040763] rtsx_pci 0000:c0:00.0: Switch card clock to 30MHz
>>>>> [  102.040764] rtsx_pci 0000:c0:00.0: Internal SSC clock: 30MHz
>> (cur_clock = 30)
>>>>> [  102.041874] rtsx_pci 0000:c0:00.0: Switch card clock to 30MHz
>>>>> [  102.041875] rtsx_pci 0000:c0:00.0: Internal SSC clock: 30MHz
>> (cur_clock = 30)
>>>>> [  102.041879] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_send_cmd_get_rsp:
>> SD/MMC CMD 8, arg = 0x000001aa
>>>>> [  102.042452] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[0] =
>> 0x000001aa
>>>>> [  102.042468] rtsx_pci 0000:c0:00.0: Switch card clock to 30MHz
>>>>> [  102.042469] rtsx_pci 0000:c0:00.0: Internal SSC clock: 30MHz
>> (cur_clock = 30)
>>>>> [  102.042474] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_send_cmd_get_rsp:
>> SD/MMC CMD 55, arg = 0x00000000
>>>>> [  102.043036] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[0] =
>> 0x00000120
>>>>> [  102.043053] rtsx_pci 0000:c0:00.0: Switch card clock to 30MHz
>>>>> [  102.043057] rtsx_pci 0000:c0:00.0: Internal SSC clock: 30MHz
>> (cur_clock = 30)
>>>>> [  102.043061] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_send_cmd_get_rsp:
>> SD/MMC CMD 41, arg = 0x59300000
>>>>> [  102.043599] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[0] =
>> 0x00ff8000
>>>>> [  102.062878] rtsx_pci 0000:c0:00.0: Switch card clock to 30MHz
>>>>> [  102.062885] rtsx_pci 0000:c0:00.0: Internal SSC clock: 30MHz
>> (cur_clock = 30)
>>>>> [  102.062890] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_send_cmd_get_rsp:
>> SD/MMC CMD 55, arg = 0x00000000
>>>>> [  102.063450] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[0] =
>> 0x00000120
>>>>> [  102.063462] rtsx_pci 0000:c0:00.0: Switch card clock to 30MHz
>>>>> [  102.063463] rtsx_pci 0000:c0:00.0: Internal SSC clock: 30MHz
>> (cur_clock = 30)
>>>>> [  102.063467] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_send_cmd_get_rsp:
>> SD/MMC CMD 41, arg = 0x59300000
>>>>> [  102.064012] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[0] =
>> 0x00ff8000
>>>>> [  102.104036] rtsx_pci 0000:c0:00.0: Switch card clock to 30MHz
>>>>> [  102.104043] rtsx_pci 0000:c0:00.0: Internal SSC clock: 30MHz
>> (cur_clock = 30)
>>>>> [  102.104047] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_send_cmd_get_rsp:
>> SD/MMC CMD 55, arg = 0x00000000
>>>>> [  102.104603] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[0] =
>> 0x00000120
>>>>> [  102.104619] rtsx_pci 0000:c0:00.0: Switch card clock to 30MHz
>>>>> [  102.104620] rtsx_pci 0000:c0:00.0: Internal SSC clock: 30MHz
>> (cur_clock = 30)
>>>>> [  102.104624] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_send_cmd_get_rsp:
>> SD/MMC CMD 41, arg = 0x59300000
>>>>> [  102.105162] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[0] =
>> 0x00ff8000
>>>>> [  102.184867] rtsx_pci 0000:c0:00.0: Switch card clock to 30MHz
>>>>> [  102.184874] rtsx_pci 0000:c0:00.0: Internal SSC clock: 30MHz
>> (cur_clock = 30)
>>>>> [  102.184878] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_send_cmd_get_rsp:
>> SD/MMC CMD 55, arg = 0x00000000
>>>>> [  102.185438] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[0] =
>> 0x00000120
>>>>> [  102.185446] rtsx_pci 0000:c0:00.0: Switch card clock to 30MHz
>>>>> [  102.185447] rtsx_pci 0000:c0:00.0: Internal SSC clock: 30MHz
>> (cur_clock = 30)
>>>>> [  102.185451] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_send_cmd_get_rsp:
>> SD/MMC CMD 41, arg = 0x59300000
>>>>> [  102.185990] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[0] =
>> 0x00ff8000
>>>>> [  102.265861] rtsx_pci 0000:c0:00.0: Switch card clock to 30MHz
>>>>> [  102.265868] rtsx_pci 0000:c0:00.0: Internal SSC clock: 30MHz
>> (cur_clock = 30)
>>>>> [  102.265872] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_send_cmd_get_rsp:
>> SD/MMC CMD 55, arg = 0x00000000
>>>>> [  102.266434] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[0] =
>> 0x00000120
>>>>> [  102.266450] rtsx_pci 0000:c0:00.0: Switch card clock to 30MHz
>>>>> [  102.266452] rtsx_pci 0000:c0:00.0: Internal SSC clock: 30MHz
>> (cur_clock = 30)
>>>>> [  102.266456] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_send_cmd_get_rsp:
>> SD/MMC CMD 41, arg = 0x59300000
>>>>> [  102.266996] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[0] =
>> 0x00ff8000
>>>>> [  102.346859] rtsx_pci 0000:c0:00.0: Switch card clock to 30MHz
>>>>> [  102.346869] rtsx_pci 0000:c0:00.0: Internal SSC clock: 30MHz
>> (cur_clock = 30)
>>>>> [  102.346875] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_send_cmd_get_rsp:
>> SD/MMC CMD 55, arg = 0x00000000
>>>>> [  102.347441] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[0] =
>> 0x00000120
>>>>> [  102.347450] rtsx_pci 0000:c0:00.0: Switch card clock to 30MHz
>>>>> [  102.347451] rtsx_pci 0000:c0:00.0: Internal SSC clock: 30MHz
>> (cur_clock = 30)
>>>>> [  102.347455] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_send_cmd_get_rsp:
>> SD/MMC CMD 41, arg = 0x59300000
>>>>> [  102.348005] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[0] =
>> 0x00ff8000
>>>>> [  102.427853] rtsx_pci 0000:c0:00.0: Switch card clock to 30MHz
>>>>> [  102.427860] rtsx_pci 0000:c0:00.0: Internal SSC clock: 30MHz
>> (cur_clock = 30)
>>>>> [  102.427865] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_send_cmd_get_rsp:
>> SD/MMC CMD 55, arg = 0x00000000
>>>>> [  102.428434] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[0] =
>> 0x00000120
>>>>> [  102.428443] rtsx_pci 0000:c0:00.0: Switch card clock to 30MHz
>>>>> [  102.428444] rtsx_pci 0000:c0:00.0: Internal SSC clock: 30MHz
>> (cur_clock = 30)
>>>>> [  102.428448] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_send_cmd_get_rsp:
>> SD/MMC CMD 41, arg = 0x59300000
>>>>> [  102.428995] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[0] =
>> 0x41ff8000
>>>>> [  102.508837] rtsx_pci 0000:c0:00.0: Switch card clock to 30MHz
>>>>> [  102.508845] rtsx_pci 0000:c0:00.0: Internal SSC clock: 30MHz
>> (cur_clock = 30)
>>>>> [  102.508852] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_send_cmd_get_rsp:
>> SD/MMC CMD 55, arg = 0x00000000
>>>>> [  102.509408] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[0] =
>> 0x00000120
>>>>> [  102.509440] rtsx_pci 0000:c0:00.0: Switch card clock to 30MHz
>>>>> [  102.509445] rtsx_pci 0000:c0:00.0: Internal SSC clock: 30MHz
>> (cur_clock = 30)
>>>>> [  102.509452] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_send_cmd_get_rsp:
>> SD/MMC CMD 41, arg = 0x59300000
>>>>> [  102.509996] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[0] =
>> 0xc1ff8000
>>>>> [  102.510008] mmc0: cannot verify signal voltage switch
>>>>> [  102.510031] rtsx_pci 0000:c0:00.0: Switch card clock to 30MHz
>>>>> [  102.510033] rtsx_pci 0000:c0:00.0: Internal SSC clock: 30MHz
>> (cur_clock = 30)
>>>>> [  102.510038] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_send_cmd_get_rsp:
>> SD/MMC CMD 11, arg = 0x00000000
>>>>> [  102.510587] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[0] =
>> 0x00000320
>>>>> [  102.511837] rtsx_pci 0000:c0:00.0: Switch card clock to 30MHz
>>>>> [  102.511838] rtsx_pci 0000:c0:00.0: Internal SSC clock: 30MHz
>> (cur_clock = 30)
>>>>> [  102.511840] rtsx_pci_sdmmc rtsx_pci_sdmmc.0:
>> sdmmc_switch_voltage: signal_voltage = 1
>>>>> [  102.598474] rtsx_pci 0000:c0:00.0: Switch card clock to 30MHz
>>>>> [  102.598480] rtsx_pci 0000:c0:00.0: Internal SSC clock: 30MHz
>> (cur_clock = 30)
>>>>> [  102.599674] rtsx_pci 0000:c0:00.0: Switch card clock to 30MHz
>>>>> [  102.599679] rtsx_pci 0000:c0:00.0: Internal SSC clock: 30MHz
>> (cur_clock = 30)
>>>>> [  102.599684] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_send_cmd_get_rsp:
>> SD/MMC CMD 2, arg = 0x00000000
>>>>> [  102.600608] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[0] =
>> 0x03534453
>>>>> [  102.600612] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[1] =
>> 0x52303254
>>>>> [  102.600613] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[2] =
>> 0x87bacf26
>>>>> [  102.600614] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[3] =
>> 0xfe018901
>>>>> [  102.600630] rtsx_pci 0000:c0:00.0: Switch card clock to 30MHz
>>>>> [  102.600631] rtsx_pci 0000:c0:00.0: Internal SSC clock: 30MHz
>> (cur_clock = 30)
>>>>> [  102.600635] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_send_cmd_get_rsp:
>> SD/MMC CMD 3, arg = 0x00000000
>>>>> [  102.601176] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[0] =
>> 0xd5550500
>>>>> [  102.601195] rtsx_pci 0000:c0:00.0: Switch card clock to 30MHz
>>>>> [  102.601199] rtsx_pci 0000:c0:00.0: Internal SSC clock: 30MHz
>> (cur_clock = 30)
>>>>> [  102.601205] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_send_cmd_get_rsp:
>> SD/MMC CMD 7, arg = 0xd5550000
>>>>> [  102.601770] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[0] =
>> 0x00000700
>>>>> [  102.601785] rtsx_pci 0000:c0:00.0: Switch card clock to 30MHz
>>>>> [  102.601786] rtsx_pci 0000:c0:00.0: Internal SSC clock: 30MHz
>> (cur_clock = 30)
>>>>> [  102.601793] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 6, arg = 0x00fffff0
>>>>> [  102.604338] rtsx_pci 0000:c0:00.0: Switch card clock to 30MHz
>>>>> [  102.604340] rtsx_pci 0000:c0:00.0: Internal SSC clock: 30MHz
>> (cur_clock = 30)
>>>>> [  102.604345] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_send_cmd_get_rsp:
>> SD/MMC CMD 55, arg = 0xd5550000
>>>>> [  102.604887] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[0] =
>> 0x00000920
>>>>> [  102.604893] rtsx_pci 0000:c0:00.0: Switch card clock to 30MHz
>>>>> [  102.604894] rtsx_pci 0000:c0:00.0: Internal SSC clock: 30MHz
>> (cur_clock = 30)
>>>>> [  102.604899] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_send_cmd_get_rsp:
>> SD/MMC CMD 6, arg = 0x00000002
>>>>> [  102.605462] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[0] =
>> 0x00000920
>>>>> [  102.605480] rtsx_pci 0000:c0:00.0: Switch card clock to 30MHz
>>>>> [  102.605481] rtsx_pci 0000:c0:00.0: Internal SSC clock: 30MHz
>> (cur_clock = 30)
>>>>> [  102.605486] rtsx_pci 0000:c0:00.0: Switch card clock to 30MHz
>>>>> [  102.605487] rtsx_pci 0000:c0:00.0: Internal SSC clock: 30MHz
>> (cur_clock = 30)
>>>>> [  102.605493] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 6, arg = 0x80ff1fff
>>>>> [  102.608016] rtsx_pci 0000:c0:00.0: Switch card clock to 30MHz
>>>>> [  102.608019] rtsx_pci 0000:c0:00.0: Internal SSC clock: 30MHz
>> (cur_clock = 30)
>>>>> [  102.608025] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 6, arg = 0x80fffff3
>>>>> [  102.612934] rtsx_pci 0000:c0:00.0: Switch card clock to 30MHz
>>>>> [  102.612936] rtsx_pci 0000:c0:00.0: Internal SSC clock: 30MHz
>> (cur_clock = 30)
>>>>> [  102.612950] rtsx_pci 0000:c0:00.0: Switch card clock to 208MHz
>>>>> [  102.612951] rtsx_pci 0000:c0:00.0: Internal SSC clock: 208MHz
>> (cur_clock = 30)
>>>>> [  102.612951] rtsx_pci 0000:c0:00.0: n = 206, div = 1
>>>>> [  102.612952] rtsx_pci 0000:c0:00.0: ssc_depth = 2
>>>>> [  102.613105] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(TX):
>> sample_point = 25
>>>>> [  102.613115] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 0
>>>>> [  102.613126] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.614718] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 1
>>>>> [  102.614732] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.614759] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 2
>>>>> [  102.614770] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.614796] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 3
>>>>> [  102.614815] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.614842] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 4
>>>>> [  102.614853] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.614879] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 5
>>>>> [  102.614890] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.614916] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 6
>>>>> [  102.614927] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.614952] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 7
>>>>> [  102.614963] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.614987] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 8
>>>>> [  102.614998] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.615024] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 9
>>>>> [  102.615035] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.615059] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 10
>>>>> [  102.615071] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.615095] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 11
>>>>> [  102.615107] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.615132] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 12
>>>>> [  102.615144] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.615172] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: rtsx_pci_send_cmd
>> fail (err = -22)
>>>>> [  102.615178] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 13
>>>>> [  102.615187] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.615211] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: rtsx_pci_send_cmd
>> fail (err = -22)
>>>>> [  102.615215] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 14
>>>>> [  102.615223] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.615235] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: rtsx_pci_send_cmd
>> fail (err = -22)
>>>>> [  102.615350] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 15
>>>>> [  102.615358] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.615383] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: rtsx_pci_send_cmd
>> fail (err = -22)
>>>>> [  102.615387] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 16
>>>>> [  102.615395] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.615419] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: rtsx_pci_send_cmd
>> fail (err = -22)
>>>>> [  102.615424] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 17
>>>>> [  102.615432] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.615458] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: rtsx_pci_send_cmd
>> fail (err = -22)
>>>>> [  102.615462] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 18
>>>>> [  102.615470] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.615495] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: rtsx_pci_send_cmd
>> fail (err = -22)
>>>>> [  102.615499] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 19
>>>>> [  102.615507] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.615531] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 20
>>>>> [  102.615539] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.615562] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 21
>>>>> [  102.615570] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.615594] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 22
>>>>> [  102.615602] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.615625] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 23
>>>>> [  102.615633] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.615657] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 24
>>>>> [  102.615665] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.615689] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 25
>>>>> [  102.615697] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.615722] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 26
>>>>> [  102.615730] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.615754] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 27
>>>>> [  102.615762] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.615785] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 28
>>>>> [  102.615793] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.615817] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 29
>>>>> [  102.615825] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.615849] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 30
>>>>> [  102.615858] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.615890] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 31
>>>>> [  102.615907] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.615933] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 0
>>>>> [  102.615943] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.615968] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 1
>>>>> [  102.615977] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.616001] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 2
>>>>> [  102.616010] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.616034] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 3
>>>>> [  102.616042] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.616066] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 4
>>>>> [  102.616076] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.616100] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 5
>>>>> [  102.616109] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.616133] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 6
>>>>> [  102.616142] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.616168] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 7
>>>>> [  102.616180] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.616207] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 8
>>>>> [  102.616219] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.616244] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 9
>>>>> [  102.616257] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.616282] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 10
>>>>> [  102.616294] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.616319] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 11
>>>>> [  102.616331] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.616356] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 12
>>>>> [  102.616368] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.616395] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: rtsx_pci_send_cmd
>> fail (err = -22)
>>>>> [  102.616402] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 13
>>>>> [  102.616413] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.616439] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: rtsx_pci_send_cmd
>> fail (err = -22)
>>>>> [  102.616445] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 14
>>>>> [  102.616457] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.616471] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: rtsx_pci_send_cmd
>> fail (err = -22)
>>>>> [  102.616580] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 15
>>>>> [  102.616592] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.616606] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: rtsx_pci_send_cmd
>> fail (err = -22)
>>>>> [  102.616714] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 16
>>>>> [  102.616726] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.616753] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: rtsx_pci_send_cmd
>> fail (err = -22)
>>>>> [  102.616758] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 17
>>>>> [  102.616770] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.616796] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: rtsx_pci_send_cmd
>> fail (err = -22)
>>>>> [  102.616809] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 18
>>>>> [  102.616821] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.616848] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: rtsx_pci_send_cmd
>> fail (err = -22)
>>>>> [  102.616854] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 19
>>>>> [  102.616866] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.616891] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 20
>>>>> [  102.616903] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.616928] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 21
>>>>> [  102.616940] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.616965] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 22
>>>>> [  102.616978] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.617003] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 23
>>>>> [  102.617015] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.617040] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 24
>>>>> [  102.617051] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.617076] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 25
>>>>> [  102.617088] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.617111] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 26
>>>>> [  102.617120] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.617143] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 27
>>>>> [  102.617152] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.617175] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 28
>>>>> [  102.617184] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.617207] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 29
>>>>> [  102.617216] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.617239] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 30
>>>>> [  102.617247] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.617271] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 31
>>>>> [  102.617280] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.617303] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 0
>>>>> [  102.617312] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.617335] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 1
>>>>> [  102.617343] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.617367] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 2
>>>>> [  102.617375] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.617398] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 3
>>>>> [  102.617407] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.617430] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 4
>>>>> [  102.617439] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.617462] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 5
>>>>> [  102.617471] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.617494] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 6
>>>>> [  102.617502] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.617525] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 7
>>>>> [  102.617534] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.617557] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 8
>>>>> [  102.617566] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.617589] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 9
>>>>> [  102.617598] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.617621] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 10
>>>>> [  102.617630] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.617653] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 11
>>>>> [  102.617662] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.617686] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 12
>>>>> [  102.617694] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.617719] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: rtsx_pci_send_cmd
>> fail (err = -22)
>>>>> [  102.617723] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 13
>>>>> [  102.617732] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.617756] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: rtsx_pci_send_cmd
>> fail (err = -22)
>>>>> [  102.617761] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 14
>>>>> [  102.617770] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.617782] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: rtsx_pci_send_cmd
>> fail (err = -22)
>>>>> [  102.617889] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 15
>>>>> [  102.617898] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.617911] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: rtsx_pci_send_cmd
>> fail (err = -22)
>>>>> [  102.618017] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 16
>>>>> [  102.618026] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.618051] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: rtsx_pci_send_cmd
>> fail (err = -22)
>>>>> [  102.618056] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 17
>>>>> [  102.618064] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.618089] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: rtsx_pci_send_cmd
>> fail (err = -22)
>>>>> [  102.618093] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 18
>>>>> [  102.618102] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.618127] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: rtsx_pci_send_cmd
>> fail (err = -22)
>>>>> [  102.618132] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 19
>>>>> [  102.618140] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.618164] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 20
>>>>> [  102.618173] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.618196] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 21
>>>>> [  102.618205] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.618228] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 22
>>>>> [  102.618237] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.618260] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 23
>>>>> [  102.618268] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.618292] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 24
>>>>> [  102.618301] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.618324] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 25
>>>>> [  102.618333] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.618356] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 26
>>>>> [  102.618364] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.618388] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 27
>>>>> [  102.618397] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.618421] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 28
>>>>> [  102.618429] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.618454] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 29
>>>>> [  102.618463] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.618488] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 30
>>>>> [  102.618497] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.618520] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 31
>>>>> [  102.618529] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_data:
>> SD/MMC CMD 19, arg = 0x00000000
>>>>> [  102.618552] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: RX raw_phase_map[0]
>> = 0xfff80fff
>>>>> [  102.618554] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: RX raw_phase_map[1]
>> = 0xfff80fff
>>>>> [  102.618555] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: RX raw_phase_map[2]
>> = 0xfff80fff
>>>>> [  102.618556] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: RX phase_map =
>> 0xfff80fff
>>>>> [  102.618558] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: phase: [map:fff80fff]
>> [maxlen:25] [final:31]
>>>>> [  102.618559] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_change_phase(RX):
>> sample_point = 31
>>>>> [  102.618579] rtsx_pci 0000:c0:00.0: Switch card clock to 208MHz
>>>>> [  102.618581] rtsx_pci 0000:c0:00.0: Internal SSC clock: 208MHz
>> (cur_clock = 208)
>>>>> [  102.618586] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_write_data:
>> SD/MMC CMD 49, arg = 0x10020800
>>>>> [  102.618587] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_send_cmd_get_rsp:
>> SD/MMC CMD 49, arg = 0x10020800
>>>>> [  102.618598] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[0] =
>> 0x00000900
>>>>> [  102.618754] rtsx_pci 0000:c0:00.0: Switch card clock to 208MHz
>>>>> [  102.618756] rtsx_pci 0000:c0:00.0: Internal SSC clock: 208MHz
>> (cur_clock = 208)
>>>>> [  102.618759] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_send_cmd_get_rsp:
>> SD/MMC CMD 13, arg = 0xd5550000
>>>>> [  102.618769] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[0] =
>> 0x00000900
>>>>> [  102.618784] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: pre dma sg: 1
>>>>> [  102.618794] rtsx_pci 0000:c0:00.0: Switch card clock to 208MHz
>>>>> [  102.618795] rtsx_pci 0000:c0:00.0: Internal SSC clock: 208MHz
>> (cur_clock = 208)
>>>>> [  102.618798] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_read_long_data:
>> SD/MMC CMD 18, arg = 0xc44607f8
>>>>> [  102.618800] rtsx_pci 0000:c0:00.0: DMA addr: 0x675e5000, Len:
>> 0x1000
>>>>> [  102.619019] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_send_cmd_get_rsp:
>> SD/MMC CMD 12, arg = 0x00000000
>>>>> [  102.619030] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[0] =
>> 0x00000b00
>>>>> [  102.619066] rtsx_pci 0000:c0:00.0: Switch card clock to 208MHz
>>>>> [  102.619068] rtsx_pci 0000:c0:00.0: Internal SSC clock: 208MHz
>> (cur_clock = 208)
>>>>> [  102.619074] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sd_send_cmd_get_rsp:
>> SD/MMC CMD 13, arg = 0xd5550000
>>>>> [  102.619085] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: cmd->resp[0] =
>> 0x00000900
>>>>> [  102.619090] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: sdmmc_get_cd:
>> RTSX_BIPR = 0x00010000
>>>>> [  102.624418] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: pre dma sg: 17
>>>>> [  102.624445] rtsx_pci 0000:c0:00.0: Switch card clock to 208MHz
>>>>> [  102.624448] rtsx_pci 0000:c0:00.0: Internal SSC clock: 208MHz
>> (cur_clock = 208)
>>>>>
>>>>> I've included a readout of sudo lspci -s c0:00.0 -xxxx below:
>>>>>
>>>>> c0:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. RTS525A
>> PCI Express Card Reader (rev 01)
>>>>> 00: ec 10 5a 52 06 04 10 00 01 00 00 ff 10 00 00 00
>>>>> 10: 00 00 00 00 00 00 b0 b0 00 00 00 00 00 00 00 00
>>>>> 20: 00 00 00 00 00 00 00 00 00 00 00 00 ec 10 5a 52
>>>>> 30: 00 00 00 00 80 00 00 00 00 00 00 00 ff 01 00 00
>>>>> 40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 80: 01 90 c3 f7 03 01 00 00 00 00 00 00 00 00 00 00
>>>>> 90: 05 b0 81 00 00 10 e0 fe 00 00 00 00 22 00 00 00
>>>>> a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> b0: 10 00 02 00 c2 8f 2c 01 30 20 19 00 12 7c 47 00
>>>>> c0: 42 01 12 10 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> d0: 00 00 00 00 10 08 0c 00 00 04 00 00 06 00 00 00
>>>>> e0: 02 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 100: 01 00 82 14 00 00 00 00 00 00 40 00 30 20 46 00
>>>>> 110: 00 20 00 00 00 60 00 00 a0 00 00 00 00 00 00 00
>>>>> 120: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 130: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 140: 00 00 00 00 00 00 00 00 03 00 81 15 00 e0 4c 00
>>>>> 150: 01 00 00 00 00 00 00 00 18 00 01 16 01 10 01 10
>>>>> 160: 1e 00 01 00 1f 3c 31 00 0f 00 99 40 49 00 00 00
>>>>> 170: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 180: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 190: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 1a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 1b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 1c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 1d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 1e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 1f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 200: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 210: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 220: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 230: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 240: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 250: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 260: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 270: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 280: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 290: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 2a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 2b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 2c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 2d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 2e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 2f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 300: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 310: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 320: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 330: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 340: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 350: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 360: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 370: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 380: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 390: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 3a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 3b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 3c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 3d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 3e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 3f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 400: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 410: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 420: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 430: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 440: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 450: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 460: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 470: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 480: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 490: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 4a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 4b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 4c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 4d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 4e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 4f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 500: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 510: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 520: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 530: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 540: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 550: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 560: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 570: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 580: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 590: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 5a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 5b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 5c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 5d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 5e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 5f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 610: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 620: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 630: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 640: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 650: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 660: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 670: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 680: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 690: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 6a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 6b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 6c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 6d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 6e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 6f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 700: 68 00 38 01 ff ff ff ff 04 00 00 07 01 ff ff 5b
>>>>> 710: 20 01 01 00 00 00 00 00 00 00 01 00 80 02 00 00
>>>>> 720: 00 00 00 00 aa ff ff ee 11 7a f6 03 10 03 00 08
>>>>> 730: 80 00 01 00 ff 0f 01 00 40 00 01 00 01 00 00 00
>>>>> 740: 0f 00 00 00 00 00 00 00 20 40 20 40 04 40 20 00
>>>>> 750: 00 00 80 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 760: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 770: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 780: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 790: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 7a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 7b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 7c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 7d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 7e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 7f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 800: 00 00 00 00 00 00 00 00 00 00 00 00 ff 01 00 00
>>>>> 810: 94 b3 c8 24 75 1f 00 00 00 00 00 00 00 00 00 00
>>>>> 820: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 830: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 840: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 850: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 860: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 870: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 880: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 890: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 8a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 8b0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00 00
>>>>> 8c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 8d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 8e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 8f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 900: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 910: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 920: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 930: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 940: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 950: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 960: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 970: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 980: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 990: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 9a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 9b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 9c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 9d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 9e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 9f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> a00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> a10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> a20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> a30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> a40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> a50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> a60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> a70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> a80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> a90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> aa0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> ab0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> ac0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> ad0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> ae0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> af0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> b00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> b10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> b20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> b30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> b40: 01 00 00 00 d3 00 00 00 00 00 00 00 00 00 00 00
>>>>> b50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> b60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> b70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> b80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> b90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> ba0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> bb0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> bc0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> bd0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> be0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> bf0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> c00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> c10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> c20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> c30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> c40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> c50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> c60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> c70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> c80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> c90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> ca0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> cb0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> cc0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> cd0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> ce0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> cf0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> d00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> d10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> d20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> d30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> d40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> d50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> d60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> d70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> d80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> d90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> da0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> db0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> dc0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> dd0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> de0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> df0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> e00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> e10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> e20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> e30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> e40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> e50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> e60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> e70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> e80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> e90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> ea0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> eb0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> ec0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> ed0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> ee0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> ef0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> f10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> f20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> f30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> f40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> f50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> f60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> f70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> f90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> fa0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> fb0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> fc0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> fd0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> fe0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> ff0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>>
>>>>> deck@legion-go-2 ~> sudo cat /sys/kernel/debug/mmc0/ios
>>>>> clock:          208000000 Hz
>>>>> vdd:            21 (3.3 ~ 3.4 V)
>>>>> bus mode:       2 (push-pull)
>>>>> chip select:    0 (don't care)
>>>>> power mode:     2 (on)
>>>>> bus width:      2 (4 bits)
>>>>> timing spec:    6 (sd uhs SDR104)
>>>>> signal voltage: 1 (1.80 V)
>>>>> driver type:    0 (driver type B)
>>>>>
>>>>> As a workaround, not setting MMC_CAP_AGGRESSIVE_PM seems to
>> resolve the issue:
>>>>>
>>>>> diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c
>> b/drivers/mmc/host/rtsx_pci_sdmmc.c
>>>>> index 1e5170435cf8..a7c7daf66d5c 100644
>>>>> --- a/drivers/mmc/host/rtsx_pci_sdmmc.c
>>>>> +++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
>>>>> @@ -1499,7 +1499,7 @@ static void realtek_init_host(struct
>> realtek_pci_sdmmc *host)
>>>>>         mmc->caps = MMC_CAP_4_BIT_DATA |
>> MMC_CAP_SD_HIGHSPEED |
>>>>>                 MMC_CAP_MMC_HIGHSPEED |
>> MMC_CAP_BUS_WIDTH_TEST |
>>>>>                 MMC_CAP_UHS_SDR12 | MMC_CAP_UHS_SDR25;
>>>>> -       if (pcr->rtd3_en)
>>>>> +       if (pcr->rtd3_en && PCI_PID(pcr) != PID_525A)
>>>>>                 mmc->caps = mmc->caps |
>> MMC_CAP_AGGRESSIVE_PM;
>>>>>         mmc->caps2 = MMC_CAP2_NO_PRESCAN_POWERUP |
>> MMC_CAP2_FULL_PWR_CYCLE |
>>>>>                 MMC_CAP2_NO_SDIO;
>>>>> --
>>>>> 2.52.0
>>>>>
>>>>> I think what's happening here is that RTS525A shuts off power to the card
>> reader when games are idle for 10 seconds or more, and then when the game
>> goes to load new assets it has to go through the whole re-tuning process which
>> takes 1-2 seconds. The other brands of card readers I have keep the device
>> powered the whole time so they do not have this issue, and that's what
>> untagging MMC_CAP_AGGRESSIVE_PM seems to mimic.
>>>>
>>>> Right, MMC_CAP_AGGRESSIVE_PM does exactly what you think. If there
>> are
>>>> an idle period of no requests for the SD card, the mmc core may decide
>>>> to power-off the card for those mmc host drivers that has set
>>>> MMC_CAP_AGGRESSIVE_PM. The idea is that we want to avoid wasting
>> power
>>>> when the card is unused, which is typically important on some battery
>>>> driven devices.
>>>>
>>>> The main problem however, is that we are lacking a common policy for
>>>> how to handle this generically for all eMMC/SD cards. Ideally it
>>>> should be independent of what mmc host drivers that is managing it,
>>>> but that's not the case.
>>>>
>>>> That said, without changing the code you can use sysfs to either tweak
>>>> the idle-period or to simply prevent "runtime_suspend" (meaning
>>>> power-off) for the SD card.
>>>>
> 
> Hi Ulf, Matthew
> 
> In our Windows card reader driver, the idle period time is set to approximately 10 seconds. 
> Is there any recommended way to control or configure this idle period time?

I tried adjusting pm_schedule_suspend(device, 10000); in rtsx_pcr, but this just increases the time until you inevitably run into the issue. There are some games that can go a very long time in runtime_suspend without loading new assets, but when they inevitably go into runtime_resume after say 3 or 5 minutes, this hang in gameplay seems unavoidable with MMC_CAP_AGGRESSIVE_PM in particular. I found an old laptop of mine with an RTS5261 reader and that has the same issue unless I disable MMC_CAP_AGGRESSIVE_PM.

> Or is it possible to introduce a capability tag that is less aggressive than MMC_CAP_AGGRESSIVE_PM?

Full disclosure: This is my first time looking at mmc/rtsx code, so I'll defer to Ulf on this.

> Since most notebooks have very strict power-saving requirements during idle states, 
> we are not able to avoid using the MMC_CAP_AGGRESSIVE_PM capability.

The only other comparison I have is from card readers in other devices of mine, a Genesys Logic GL9767 in a ROG Ally X and an O2 Micro in my Steam Deck. For both of these, the card reader drivers do not seem to implement any form of runtime power management on Linux, so the experience when playing games off of them has been flawless.

Matt

> 
> 
>>>> For example, find the corresponding device for the mmc/sd card in
>>>> sysfs and do: echo on >.../power/control to prevent runtime suspend.
>>>
>>> I tried the runtime solution during debugging, however the card reader still
>> shuts off while idle:
>>>
>>> deck@legion-go-2 ~> cat
>> /sys/bus/pci/drivers/rtsx_pci/0000:c0:00.0/power/control
>>> on
>>
>> Ah, I misunderstood. I should have used
>> /sys/bus/mmc/devices/mmc0:d555/power/control, that does work at runtime.
>>
>> Matt
>>
>>>
>>> deck@legion-go-2 ~> sudo cat /sys/kernel/debug/mmc0/ios
>>> clock:          0 Hz
>>> vdd:            0 (invalid)
>>> bus mode:       2 (push-pull)
>>> chip select:    0 (don't care)
>>> power mode:     0 (off)
>>> bus width:      0 (1 bits)
>>> timing spec:    0 (legacy)
>>> signal voltage: 1 (1.80 V)
>>> driver type:    0 (driver type B)
>>>
>>> Only removing MMC_CAP_AGGRESSIVE_PM seemed to actually work.
>>>
>>>>
>>>>>
>>>>> Should I upstream the above as a quirk or is there further debugging I can
>> assist with to find another workaround for the gameplay stutter? I've found a
>> couple other bugs with the card reader too but I will send out separate threads
>> to keep things organized.
>>>>
>>>> Please post a formal patch, then let's discuss what to do about it.
>>>
>>> Will send out that patch shortly.
>>>
>>> Matt
>>>
>>>>
>>>>>
>>>>> Thanks!
>>>>>
>>>>> Matt
>>>>
>>>> Kind regards
>>>> Uffe
>>>
> 

