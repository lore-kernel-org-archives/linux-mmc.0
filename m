Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F73A12E1F7
	for <linux-mmc@vger.kernel.org>; Tue,  9 Apr 2024 11:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712662748; cv=none; b=bucaVMZhYRKdYo6393RH/wIoYgVNG2uE31lDZ64DKxiweBk/TPwVz5B/ucCbFuaeGBxK/Q8CnAPs8yRuXIEKPUeCd1qqeMBqjlLHX8QJVTvgfFmrpsDGWPwzZ0Ud2TlMrvqdWqQWIjsEcODlye98ReAgSUYka2ZNCy+U4F/5geM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712662748; c=relaxed/simple;
	bh=DDhUClf4dmuomAJ18tNn1U21AaJ69EHGgLRFmX/f7UU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fseVu9YXsrCYTw9hPHbZX8RyteZKXMsIh3ePzo4rFAuSoU83lArBwlVCcs98tQWSGO44NpoctX1HnU7oyEf+jyUa1qJBjsis+HFsmdI0AgBWKK06FgaMoldxDz1eGNVfHnKVEFDJB3rYCD+HgcC9lFHZn6hEJ2T2OoT9UKhODQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IEGD60RE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IEGD60RE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712662746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iITUPaMv9HBGNHWvKkhcI+BSldwWtbGOLOTOQg2Kbfw=;
	b=IEGD60REQ1XrzEz1BEw+8HgTvxauGLlM6KuFwl/7+Mzo4QBxPTByUA8xF9elvtwRsOTo9T
	Py5uVvluGO524bt3IH2V1ZgVrnmzAJLRqJBrLaZJYOmf2oKSOo3QeZMaaym7s9qhBdsUac
	SiW3YUPqpFA0GQ/6tFs3NtKG6zs0y3k=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-HkgJ_FjAOTGT7ENIkNCSnw-1; Tue, 09 Apr 2024 07:39:04 -0400
X-MC-Unique: HkgJ_FjAOTGT7ENIkNCSnw-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2d86787efa3so31260691fa.1
        for <linux-mmc@vger.kernel.org>; Tue, 09 Apr 2024 04:39:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712662743; x=1713267543;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iITUPaMv9HBGNHWvKkhcI+BSldwWtbGOLOTOQg2Kbfw=;
        b=hccHNXFgXrmFLh88wIOuyxyhN9MSJcduJrGHv8PmC9ejllCBRZQkCePV3dvAJI3o2Q
         tHf94UGxrFl5esmI/N/vuhZF7NfOHoASnzwyjAZXX+CKeuGCyQC46SyOg8iW9C5KpwUa
         bgTVi+269MGhpS/oxKKEDbvw6yIAE/z2aTJGF+XWWWZxqeS2XRhiZYHoNGrZaDimR3qM
         QWgnBgFywRoXAkPemKYBmIzRxPa2QfOHE19gowshmj73REYuBpKZ2HCqyU4GBYyKv86E
         CQsuoQ3ZSZSY93MQjB1fNZMzkUa/ZnTBPkRjkzxw3yefckauN6B6uF400q35Qews5GAz
         jQPQ==
X-Gm-Message-State: AOJu0Ywi8253EDcY40aBiRNk+xNmTDs5uDghdk+gQ+W1kZP3WDsBmW/V
	gfYvXpHPJNTzsXSQPEyk1hdaGZhtDcqRtUVhtCjx0h9vF1odtxQ47sXKfkiGNQpOr1zhWRHT3wf
	HCYXJl2lWjszeSnjYNLBewHw6UIzKa2ZinMX9PKwtJZHsTzNepqRnduEuuw==
X-Received: by 2002:a2e:b011:0:b0:2d6:8e88:5a8b with SMTP id y17-20020a2eb011000000b002d68e885a8bmr10094458ljk.32.1712662743073;
        Tue, 09 Apr 2024 04:39:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3c9RZTMmoCjJgRmfLDFiam1CQZD9x4sBMQqCRBt4Yoc+185vkiR3m5OP/zE9kRlkr8mz4tg==
X-Received: by 2002:a2e:b011:0:b0:2d6:8e88:5a8b with SMTP id y17-20020a2eb011000000b002d68e885a8bmr10094444ljk.32.1712662742662;
        Tue, 09 Apr 2024 04:39:02 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id z16-20020a17090665d000b00a4e9cb0b620sm5607581ejn.158.2024.04.09.04.39.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 04:39:02 -0700 (PDT)
Message-ID: <5c53854a-9a16-427b-ac63-41c34cb323b2@redhat.com>
Date: Tue, 9 Apr 2024 13:39:01 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] mmc: sdhci-acpi: Disable UHS/1.8V modes on Lenovo
 Yoga Tablet 2 series sdcard slot
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Andy Shevchenko <andy@kernel.org>
References: <20240408195244.248280-1-hdegoede@redhat.com>
 <20240408195244.248280-5-hdegoede@redhat.com>
 <199bb4aa-c6b5-453e-be37-58bbf468800c@intel.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <199bb4aa-c6b5-453e-be37-58bbf468800c@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Adrian,

On 4/9/24 12:37 PM, Adrian Hunter wrote:
> On 8/04/24 22:52, Hans de Goede wrote:
>> Unlike all other Bay Trail devices I have (quite a few) the BIOS on
>> the Lenovo Yoga Tablet 2 830 / 1050 and Lenovo Yoga Tablet 2 Pro 1380 (8",
>> 10" and 13") models sets the SDHCI_SUPPORT_DDR50 bit in the sdcard slots'
>> SDHCI controller's Caps_1 register which causes Linux to try and use
>> UHS SDR12 / SDR25 and DDR50 modes on UHS cards.
>>
>> These tablets do have 1.8V signalling implemented in the hw level through
>> the Bay Trail SoC's SD3_1P8EN pin. But trying to use UHS modes leads to
>> lots of errors like these:
>>
>> [  225.272001] mmc2: Unexpected interrupt 0x04000000.
>> [  225.272024] mmc2: sdhci: ============ SDHCI REGISTER DUMP ===========
>> [  225.272034] mmc2: sdhci: Sys addr:  0x0712c400 | Version:  0x0000b502
>> [  225.272044] mmc2: sdhci: Blk size:  0x00007200 | Blk cnt:  0x00000007
>> [  225.272054] mmc2: sdhci: Argument:  0x00000000 | Trn mode: 0x00000023
>> [  225.272064] mmc2: sdhci: Present:   0x01e20002 | Host ctl: 0x00000016
>> [  225.272073] mmc2: sdhci: Power:     0x0000000f | Blk gap:  0x00000000
>> [  225.272082] mmc2: sdhci: Wake-up:   0x00000000 | Clock:    0x00000107
>> [  225.272092] mmc2: sdhci: Timeout:   0x0000000e | Int stat: 0x00000001
>> [  225.272101] mmc2: sdhci: Int enab:  0x03ff000b | Sig enab: 0x03ff000b
>> [  225.272110] mmc2: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000001
>> [  225.272119] mmc2: sdhci: Caps:      0x076864b2 | Caps_1:   0x00000004
>> [  225.272129] mmc2: sdhci: Cmd:       0x00000c1b | Max curr: 0x00000000
>> [  225.272138] mmc2: sdhci: Resp[0]:   0x00000c00 | Resp[1]:  0x00000000
>> [  225.272147] mmc2: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000900
>> [  225.272155] mmc2: sdhci: Host ctl2: 0x0000000c
>> [  225.272164] mmc2: sdhci: ADMA Err:  0x00000003 | ADMA Ptr: 0x0712c200
>> [  225.272172] mmc2: sdhci: ============================================
>>
> 
> 0x04000000 is so-called "Tuning Error" which oddly the SDHCI driver
> does not support / enable.
> 
> Could try making the IRQ handler process it and see if that helps:

Thank you. I'll give this a try when I've some time.

Note though that the factory Android OS actually also sets
(hardcodes) the SDHCI_QUIRK2_NO_1_8_V quirk2 flag for the external
microsd slot and as I mentioned I've not seen any other Bay Trail
device (and I have quite a few) enable UHS modes on their external
sdcard slot. The datasheet for the Bay Trail SoC claims UHS modes
should work, but it seems that in practice the hw-enablement work
for this was never done.

As I mentioned below the cut-off I have even contemplated to
always set SDHCI_QUIRK2_NO_1_8_V on the external sd slot for
all Bay Trail devices because of this. So I'm wondering if
it would not be safer to just disable UHS modes on Bay Trail
devices and leave things at that ?

Part of my thinking here is that given both that it is only
enabled in the first place on these 3 models as well as how old
these tablets are that it might be better to spend time elsewhere?

Regards,

Hans






> 
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index c79f73459915..746f4cf7ab03 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -3439,12 +3439,18 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
>  		host->data->error = -EILSEQ;
>  		if (!mmc_op_tuning(SDHCI_GET_CMD(sdhci_readw(host, SDHCI_COMMAND))))
>  			sdhci_err_stats_inc(host, DAT_CRC);
> -	} else if ((intmask & SDHCI_INT_DATA_CRC) &&
> +	} else if ((intmask & (SDHCI_INT_DATA_CRC | SDHCI_INT_TUNING_ERROR)) &&
>  		SDHCI_GET_CMD(sdhci_readw(host, SDHCI_COMMAND))
>  			!= MMC_BUS_TEST_R) {
>  		host->data->error = -EILSEQ;
>  		if (!mmc_op_tuning(SDHCI_GET_CMD(sdhci_readw(host, SDHCI_COMMAND))))
>  			sdhci_err_stats_inc(host, DAT_CRC);
> +		if (intmask & SDHCI_INT_TUNING_ERROR) {
> +			u16 ctrl2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +
> +			ctrl2 &= ~SDHCI_CTRL_TUNED_CLK;
> +			sdhci_writew(host, ctrl2, SDHCI_HOST_CONTROL2);
> +		}
>  	} else if (intmask & SDHCI_INT_ADMA_ERROR) {
>  		pr_err("%s: ADMA error: 0x%08x\n", mmc_hostname(host->mmc),
>  		       intmask);
> @@ -3979,7 +3985,7 @@ bool sdhci_cqe_irq(struct sdhci_host *host, u32 intmask, int *cmd_error,
>  	} else
>  		*cmd_error = 0;
>  
> -	if (intmask & (SDHCI_INT_DATA_END_BIT | SDHCI_INT_DATA_CRC)) {
> +	if (intmask & (SDHCI_INT_DATA_END_BIT | SDHCI_INT_DATA_CRC | SDHCI_INT_TUNING_ERROR)) {
>  		*data_error = -EILSEQ;
>  		if (!mmc_op_tuning(SDHCI_GET_CMD(sdhci_readw(host, SDHCI_COMMAND))))
>  			sdhci_err_stats_inc(host, DAT_CRC);
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index a20864fc0641..957c7a917ffb 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -158,6 +158,7 @@
>  #define  SDHCI_INT_BUS_POWER	0x00800000
>  #define  SDHCI_INT_AUTO_CMD_ERR	0x01000000
>  #define  SDHCI_INT_ADMA_ERROR	0x02000000
> +#define  SDHCI_INT_TUNING_ERROR	0x04000000
>  
>  #define  SDHCI_INT_NORMAL_MASK	0x00007FFF
>  #define  SDHCI_INT_ERROR_MASK	0xFFFF8000
> @@ -169,7 +170,7 @@
>  		SDHCI_INT_DATA_AVAIL | SDHCI_INT_SPACE_AVAIL | \
>  		SDHCI_INT_DATA_TIMEOUT | SDHCI_INT_DATA_CRC | \
>  		SDHCI_INT_DATA_END_BIT | SDHCI_INT_ADMA_ERROR | \
> -		SDHCI_INT_BLK_GAP)
> +		SDHCI_INT_BLK_GAP | SDHCI_INT_TUNING_ERROR)
>  #define SDHCI_INT_ALL_MASK	((unsigned int)-1)
>  
>  #define SDHCI_CQE_INT_ERR_MASK ( \
> 
> 

