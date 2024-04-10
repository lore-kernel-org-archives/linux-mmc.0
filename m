Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0482C17B4EB
	for <linux-mmc@vger.kernel.org>; Wed, 10 Apr 2024 17:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712769081; cv=none; b=MEu892B3gB5thdr+xkdpLWNRR98Lykk1rPJx4OPfsRJ3UKE5m5l+nvPPEpIFAmVqOKbt9Z5DHjA43vyOy43X/gMtjNslNXz6KjYEAAOJigSHqQvdASAJne0yaThC9KRv5MrapxmPu+uPMCd9bjQxd64IADpF5APmBQ4AuZRf1nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712769081; c=relaxed/simple;
	bh=Qk/DnNyQbKk5wsgx7w9O8MgtZE802Q4z8K99xkvDuK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jpMwLNeBE6Gj6cvoM5xraRWeZIvwk0YpdQD6EH1MNt1FRIBkNx5Zzxf8JycfLZn5+F6H04yjBUXW6AeBGtiOlfDzBvzGWgueJsK58GeKtx8D8pTnQLkphS+U/T85KXaclrhQioM7clFIjXTQtQh2btwLDyCCK5RvvX6E0cZPwmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ADkPRACw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ADkPRACw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712769078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TDCFHKUjBRf0i83FS7QPmPX8YDl0mIt9W/HRFMtaMf8=;
	b=ADkPRACwUTkbDuoSnPTuQuWQNwb019yaazFfZDjViJ6L3qaAWUvLP6lUvx9KNie8QqI9Sx
	j8KbXU003BZZngdfe/WBoWun9ROm6FYNMz/vXVz0QGKpQGRscTsMeDDDK6iEdCLbytli5V
	dXzsrtV5GlbTu/CxzPDX03kydmzZnhI=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-2QNv7SVZNbqIOs-n_Y6XXA-1; Wed, 10 Apr 2024 13:11:17 -0400
X-MC-Unique: 2QNv7SVZNbqIOs-n_Y6XXA-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-516d754664dso4115840e87.0
        for <linux-mmc@vger.kernel.org>; Wed, 10 Apr 2024 10:11:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712769076; x=1713373876;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TDCFHKUjBRf0i83FS7QPmPX8YDl0mIt9W/HRFMtaMf8=;
        b=GWF8KdaIT29wFDGTzupsIZy+6eS84ARsUOv8PeZOr73nL+WNlthu+HPPmJOBGY1yMi
         0xGBFDs7q33DY6XQP83EZDyV/BKwDTtQrSNNteBajjBuwtzW981AkTXyK8A0afOpJkMP
         /WjrgRrdrRQDNcDIXx3GB8sAJRM+lBO/Jaw7piyjTcHEFJHIqaK9M+Cgc+eRmZtSbavo
         iwRhcIpecDIzlxtkTb2rRA1V9byLICUnDZu77VNipNWEeCciE1fbP7VORRckP+iMNk3v
         5t1MCVuou8t9ubQ8/6lx69VgkYPfmVT6sDJqbIiu98qrBa9nWAciOfLyX3J7gFUqONdR
         tWrw==
X-Gm-Message-State: AOJu0YyWNOluR/a4BATaBFBi5ytfOBztN3uEu+hDZFd+F9GTy4c0SFOa
	o9jDyPGTNXgJ8Obbm0RmXzr+9C2pz8Fied2/pOjsmEFQExpDhcxBCyrEdvUo79xKjT6bEklmHdK
	DdvEwt9AwDdjoZ6EDaq+3Ht0dAH5nyWxB2BDY5EBwijNka52zmgrCahidVA==
X-Received: by 2002:ac2:42d5:0:b0:516:c3b2:91e6 with SMTP id n21-20020ac242d5000000b00516c3b291e6mr1949732lfl.69.1712769076226;
        Wed, 10 Apr 2024 10:11:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6ii4nLWBFjfAfEZU5tMGh1vgcS+lPX9peJoW604k7E41f/vea0A3D6NnXfoFRGVn29n0IFg==
X-Received: by 2002:ac2:42d5:0:b0:516:c3b2:91e6 with SMTP id n21-20020ac242d5000000b00516c3b291e6mr1949714lfl.69.1712769075755;
        Wed, 10 Apr 2024 10:11:15 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id jy23-20020a170907763700b00a4ea0479235sm7173052ejc.107.2024.04.10.10.11.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 10:11:15 -0700 (PDT)
Message-ID: <f1389cde-4273-4e4b-a24e-c61c45a82399@redhat.com>
Date: Wed, 10 Apr 2024 19:11:14 +0200
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

Good news I have applied this diff and with that everything seems
to just work. No need to add the SDHCI_QUIRK2_PRESET_VALUE_BROKEN, just
this patch from you and then things work.

I'll prepare a v3 patch-set replacing this patch with your "Tuning Error"
handling patch with you as the author.

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

