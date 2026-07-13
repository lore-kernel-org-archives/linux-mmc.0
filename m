Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD19388E4D
	for <linux-mmc@vger.kernel.org>; Mon, 13 Jul 2026 12:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783945156; cv=none; b=ddwCsLR2yEsj1qi2xTo+GBBQ5iSOHEhDnAf7ZHgpGwJ8MvtTXjw/cCc5os3QTtBppAhHEbb/J8c7/3lgXkpBZzx3r4QzAvuiQSwxwDcCQkCy0J3dsVcCBmusAPkbXW/+zkWUsbYGwXCqmxw8LC1OVbrmtjCTf+1CbQ2UlDRCWSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783945156; c=relaxed/simple;
	bh=T81MXB4tITKcfjiN9Mnsr6A1O3kh03FBrg1+SuegxCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SsOcI4SbfPP561M0q91lotPqCfb/Hp9fV+wGLsmj7FEJJDFhuO6yOCdA/wzy60xNDM0uWjZAMeUCBs8wyf+7UvRHw6CLq2KE9qFEPEVXc/58kJL+GJRXD7d1+F4l6V42dpifebsl6VMYbEihCx4q19eqkDXx0sJ1qmtPFoKXj1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lFhO0gfR; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lFhO0gfR"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A2661576;
	Mon, 13 Jul 2026 05:19:09 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F53E3F93E;
	Mon, 13 Jul 2026 05:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783945153; bh=T81MXB4tITKcfjiN9Mnsr6A1O3kh03FBrg1+SuegxCc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lFhO0gfRaqvXz0tCpgsd2TUDIqlteSiFAxR6Lc6IzLfSZDLVbm1cUUi4MweEn7TWN
	 M7fZA3kBD+rKUZDAXgsKka91LXwbi+c9l1si1eSlTZ1qTLTNHMI8NGg4lTiumX6Dsg
	 ZymjyKA0xKS/Pr7k2O9GW2BoL9Cu3aTKVVrg9cmg=
Message-ID: <ba056712-027b-4996-9b15-8f70d630ff2c@arm.com>
Date: Mon, 13 Jul 2026 13:19:10 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: bcm2835: DMA mapping improvements
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
 John Garry <john.g.garry@oracle.com>
Cc: ulfh@kernel.org, florian.fainelli@broadcom.com, rjui@broadcom.com,
 sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 linux-mmc@vger.kernel.org, hch@lst.de, martin.petersen@oracle.com,
 linux-rpi-kernel@lists.infradead.org
References: <20260706073913.538598-1-john.g.garry@oracle.com>
 <CAPx+jO8KJLdpb-H_MGzbOuQA-4mMi0r03Ba-EvLCfG8Q0sk5tA@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <CAPx+jO8KJLdpb-H_MGzbOuQA-4mMi0r03Ba-EvLCfG8Q0sk5tA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/07/2026 12:25 pm, Ulf Hansson wrote:
[...]
>> @@ -1281,10 +1279,8 @@ static int bcm2835_add_host(struct bcm2835_host *host)
>>
>>          if (!host->dma_chan_rxtx) {
>>                  dev_warn(dev, "unable to initialise DMA channel. Falling back to PIO\n");
>> -               host->use_dma = false;
>> +               host->dma_dev = NULL;
>>          } else {
>> -               host->use_dma = true;
>> -
>>                  host->dma_cfg_tx.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
>>                  host->dma_cfg_tx.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
>>                  host->dma_cfg_tx.direction = DMA_MEM_TO_DEV;
>> @@ -1300,12 +1296,18 @@ static int bcm2835_add_host(struct bcm2835_host *host)
>>                  if (dmaengine_slave_config(host->dma_chan_rxtx,
>>                                             &host->dma_cfg_tx) != 0 ||
>>                      dmaengine_slave_config(host->dma_chan_rxtx,
>> -                                          &host->dma_cfg_rx) != 0)
>> -                       host->use_dma = false;
>> +                                          &host->dma_cfg_rx) != 0) {

Hang on, doesn't this whole if condition need to be inverted? It's true 
upon dma config _failure_, thanks to the original use_dma logic being a 
bit backwards here.

Thanks,
Robin.

>> +                       host->dma_dev =
>> +                               dmaengine_get_dma_device(host->dma_chan_rxtx);
>> +               }
>>          }
>>
>>          mmc->max_segs = 128;
>> -       mmc->max_req_size = min_t(size_t, 524288, dma_max_mapping_size(dev));
>> +       mmc->max_req_size = 524288;
>> +       if (host->dma_dev) {
>> +               mmc->max_req_size = min_t(size_t, mmc->max_req_size,
>> +                               dma_max_mapping_size(host->dma_dev));
>> +       }
>>          mmc->max_seg_size = mmc->max_req_size;
>>          mmc->max_blk_size = 1024;
>>          mmc->max_blk_count =  65535;
>> @@ -1336,10 +1338,10 @@ static int bcm2835_add_host(struct bcm2835_host *host)
>>          }
>>
>>          pio_limit_string[0] = '\0';
>> -       if (host->use_dma && (PIO_THRESHOLD > 0))
>> +       if (host->dma_dev && (PIO_THRESHOLD > 0))
>>                  sprintf(pio_limit_string, " (>%d)", PIO_THRESHOLD);
>>          dev_info(dev, "loaded - DMA %s%s\n",
>> -                host->use_dma ? "enabled" : "disabled", pio_limit_string);
>> +                host->dma_dev ? "enabled" : "disabled", pio_limit_string);
>>
>>          return 0;
>>   }
>> --
>> 2.43.7
>>

