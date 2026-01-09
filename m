Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C5F19D8BC
	for <linux-mmc@vger.kernel.org>; Fri,  9 Jan 2026 02:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767926766; cv=none; b=aWmnWjcuLlmjfD54yvux0yuFllf2szw+6Ewr4IIFM4sHy7gBGznG2LNwyw9AFIBYRR1sRP1ndazHE9x2JEVZSQAnqC2RT4MXKqGBoazZX/Gaf0YWRoqx4t5GHRL8pX4yQCqTE/4jzHWu8NkmdxWuwusfbJIIOJgJ8xQqnIrlotU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767926766; c=relaxed/simple;
	bh=KH3V2vAyn6PyC8hr84jo1TcRYqCvdHVkjtt8RBPE4g4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ir5AVxqG8ARsdBjlqHjwtFlGR878waVkExDCoQXSkHfED0eaVg0SfkiDTZbcBupGEQCyeR+HnDNZlYfeNoWJcNXkVAxshrPeftvugYWx4aWzXAvEacZqJMRkduEgO8KutKR0Pt6gR0mf+pIJrj6hXfCJJLriCc8hHqNJrlndcas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gyd85k2m; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gyd85k2m"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2ae29ddaed9so1274673eec.0
        for <linux-mmc@vger.kernel.org>; Thu, 08 Jan 2026 18:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767926764; x=1768531564; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NQt2SAxQJSjsfrmwWFrCxkcKhsN86FwP+7az9OrHpoM=;
        b=gyd85k2mI+MnehBTZDx4qM30DR6l787LrdUX9iIHyjgUonOuSjpkO/85P+jeeYjhLa
         HpAIs/i8jTsInDeP4/4iJMMg4H1ZXlUp6mLK5SDBJKnrG5XfQzh5LvSvyj8sUuQsTR62
         V0di+J4gNjW/uLeod/YialVnXOKq9vKHI8Pyie4pnv6AgPKbT6sO5u6TvWoHjvGz5qIn
         LMAv/Yp5/oquOPJOoh2DiEzFW65xaZPMIfR8Qq4RV1P1eyuq7E8++g9m0Q66bGYAowNo
         sGTOZMsH6HHMU7OrxdJKv1u0VwiXQ2D54mF4jCoC/5aspKGjErq0MKpEouiuzPAo+Yxf
         vxBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767926764; x=1768531564;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NQt2SAxQJSjsfrmwWFrCxkcKhsN86FwP+7az9OrHpoM=;
        b=lEPdMiDxwD+wlShMrMjj7LDe9mvUA3HP6GIuEftq8qG9LdVv6+bLFv95Bc9TtxnH4K
         udzF8zxbiMlOmOqAFOWkvkGUu8Y/kD/MK6ff38u8uMVEaYlogYfCkOqsmwGznoCFwRbz
         25inRzb73CzjPJainIaTOZQhdZwvpOjGdETDZIq4f0UrvWQdrUSpZrtE9PwsBfGr6D0E
         mWWBI+FDgvfkPg75EDsA1XzxwcbpEkvBOUg/MkRXhewcYVUb5cyXCc67mlB9j8BVHXyg
         cwSgMJbHl7RWcvon85TXMZ0EhE/B1N9aZjs+40LsK3Zm8XZjxldjqU6JVEc59hXmsBnQ
         OWbQ==
X-Gm-Message-State: AOJu0YwP3g8CCvnsxgmtygLPQM9nxk9oOgLeelAvRlChvLIRm9dKKsZl
	E2Esxz8+g7YQnumevyRpFzsyF7LzJXXxhDqVw2E9pzHg3THpcCqPAygp
X-Gm-Gg: AY/fxX71vA8Sh7E8j2nlBg8OtMNpFihlOvdkZNn+lk8RJrOpcaNvUg0dO8KAvWQH9EG
	qINwiEGHDynrSK9Rjneitd6Rldrgw8uRIe4sfLN0SmsuEQ56dcOW5fEOmSXt3ElezkkYAXpi++k
	eWJ9iimkvhDsx5HOEdkJCfmrW48IP33eFktoYJZPRicT3dqBX8WGO5NcGqemt5IuM1/0CTbsT01
	e46JRysbBqu2nFhF0FSAu/RXRk0E7OTgAWIf17VPSzJCSaiGdIvY/pP9wwflWmaZdxjFo06HcX1
	+pGaZ3lJ/yeaofy2TpFOAF2KjwA/xj9JVJSOudIWfYlWcpiXBcoiJXD8UzX/0inNRYS3sH5GKNX
	XvelfOQGJ/3jJnvjp/Xm1CfttLH2+zGSA99DWGZVgctWjeeJgasaihQTo+IVRcdwZgj7GNb8PjY
	l/R63JkTea7WS16uFEH35lEPIZJwBLIdPmZHRR7w2XDZUOWbRiBKZRnoM7
X-Google-Smtp-Source: AGHT+IGriJPeVpCKofvqKedOaJD4vlZq8k6C7lfuCWoSMYxG1ECmTHJiO7+KduX3eNkeOr/jRJiAhw==
X-Received: by 2002:a05:7301:f90:b0:2ae:5915:47b8 with SMTP id 5a478bee46e88-2b17c84521amr5006316eec.13.1767926763807;
        Thu, 08 Jan 2026 18:46:03 -0800 (PST)
Received: from [192.168.0.243] (c-73-189-16-174.hsd1.ca.comcast.net. [73.189.16.174])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b1706a55e2sm10249657eec.8.2026.01.08.18.46.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 18:46:03 -0800 (PST)
Message-ID: <b488f3d6-68bc-49ac-8cb3-0f9f05f41020@gmail.com>
Date: Thu, 8 Jan 2026 18:46:02 -0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Tabby Kitten <nyanpasu256@gmail.com>
Subject: Re: rtsx_pci_sdmmc aborts suspend when /sys/power/wakeup_count is
 enabled
To: Adrian Hunter <adrian.hunter@intel.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, ricky_wu@realtek.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <a242799a-d427-48e1-85ef-923f34df843a@gmail.com>
 <CAPDyKFq55Vqfd7cMdmQZBzvS1Xr-Z4QaTzEeuWWn3EX4HBbP3A@mail.gmail.com>
 <CAL57YxZagMaZF1X1bpx-nB76s=vZMWhUDiVbvB9P3CLiXG-qHQ@mail.gmail.com>
 <CAPDyKFpRi8u3MPauT1hnYC1pW7L4kAohAZDsgS2pgQ=4_sjgNA@mail.gmail.com>
 <f91584df-eee3-4c26-b1da-a8049a4d77bd@intel.com>
Content-Language: en-US
In-Reply-To: <f91584df-eee3-4c26-b1da-a8049a4d77bd@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/5/26 4:31 AM, Adrian Hunter wrote:
> Seems reasonable, but isn't there also:
> 	bus_ops->suspend() == mmc_sd_suspend()
> 		_mmc_sd_suspend()
> 			mmc_claim_host(host)
>
> In general, it looks difficult to avoid runtime resume on
> the suspend path.  PCI will usually runtime resume anyway
> i.e. from pci_pm_suspend():
>
> 	/*
> 	 * PCI devices suspended at run time may need to be resumed at this
> 	 * point, because in general it may be necessary to reconfigure them for
> 	 * system suspend.  Namely, if the device is expected to wake up the
> 	 * system from the sleep state, it may have to be reconfigured for this
> 	 * purpose, or if the device is not expected to wake up the system from
> 	 * the sleep state, it should be prevented from signaling wakeup events
> 	 * going forward.
> 	 *
> 	 * Also if the driver of the device does not indicate that its system
> 	 * suspend callbacks can cope with runtime-suspended devices, it is
> 	 * better to resume the device from runtime suspend here.
> 	 */
> 	if (!dev_pm_smart_suspend(dev) || pci_dev_need_resume(pci_dev)) {
> 		pm_runtime_resume(dev);
>
> So maybe alter rtsx_pci_runtime_resume() to avoid calling
> pcr->slots[RTSX_SD_CARD].card_event() == rtsx_pci_sdmmc_card_event()
> when suspending.  Perhaps along the lines of the hack below:
>
> static int rtsx_pci_runtime_resume(struct device *device)
> {
> 	struct pci_dev *pcidev = to_pci_dev(device);
> 	struct pcr_handle *handle = pci_get_drvdata(pcidev);
> 	struct rtsx_pcr *pcr = handle->pcr;
>
> 	dev_dbg(device, "--> %s\n", __func__);
>
> 	mutex_lock(&pcr->pcr_mutex);
>
> 	rtsx_pci_write_register(pcr, HOST_SLEEP_STATE, 0x03, 0x00);
>
> 	rtsx_pci_init_hw(pcr);
>
> 	if (pcr->slots[RTSX_SD_CARD].p_dev != NULL) {
> +#if IS_ENABLED(CONFIG_SUSPEND)
> +		if (pm_suspend_target_state == PM_SUSPEND_ON)
> +#endif
> 		pcr->slots[RTSX_SD_CARD].card_event(
> 			pcr->slots[RTSX_SD_CARD].p_dev);
> 	}
>
> 	mutex_unlock(&pcr->pcr_mutex);
> 	return 0;
> }
>
>> WIP
>>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> ---
>>  drivers/mmc/core/core.c     | 18 ++++++++++++------
>>  drivers/mmc/core/core.h     | 11 ++++++++---
>>  drivers/mmc/core/queue.c    |  4 ++--
>>  drivers/mmc/core/sdio_irq.c |  2 +-
>>  4 files changed, 23 insertions(+), 12 deletions(-)
>>
>> ...

Me earlier:

> I'm attemping to manually replicate the changes on Fedora 43's
> kernel-6.18.3 checkout
> (https://docs.fedoraproject.org/en-US/quick-docs/kernel-build-custom/),
> though I'm much less experienced building kernels here than on Arch
> Linux (the Arch SSD is currently in another computer). I will be
> replying back with results once I can build and test these patches.

I've built a test kernel based on Fedora's 6.18.3 along with these two
patches. Now `sudo badsleep.sh` successfully completes on the machine
with the Realtek card reader.

  * Adrian's code would not compile until I edited
    drivers/misc/cardreader/rtsx_pcr.c and added #include <linux/suspend.h>.
  * It looks a bit janky that the inner line of code is tied to a
    different natural indentation level based on a compile-time flag.
    With suspend enabled, the function call is on the same indentation
    level as the if statement!
      o One possibility is to indent the inner code one more level
        (which is an extraneous indentation if the #if is inactive)
      o Another is to move the added condition into the surrounding `if
        (pcr->slots[RTSX_SD_CARD].p_dev != NULL)`, but this prevents us
        from adding code that /doesn't/ check pm_suspend_target_state.

I ran into a possible bug:

  * On my first boot attempt, I tried running badsleep.sh, waking the
    system, and inserted a microSD card. The card was not recognized in
    Dolphin or listed in lsblk. rtsx_pci_sdmmc was present in lsmod, and
    I saw no references to rtsx or mmc in the journal.
  * I could not reproduce this error on subsequent boots. I rebooted the
    computer, then tried badsleep.sh (with or without regular KDE sleep
    beforehand), then inserted the microSD card. At this point it was
    recognized properly. I also tried inserting the card /while/ the
    system was asleep, which worked too. I'm not sure why it failed the
    first time... dirty contacts? random bug?

