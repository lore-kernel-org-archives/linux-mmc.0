Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AE4274FD3
	for <linux-mmc@vger.kernel.org>; Wed, 17 Dec 2025 07:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765956284; cv=none; b=p9HioX1LhSnYPvRAXD7DFTlpKx7RI7l2ubbxqKpDrKswWciEcST/lWQATJCXFfGSSWxjk6US4K4OqRCh33fAGqR1Ge5TAiQFXs/x1gdZrc/y/ZVEJtSco/515fZQJ7WjgOk71RmxcvTbJafWvNrOtIqOWMeK/PTr15Zi2wciEWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765956284; c=relaxed/simple;
	bh=dUWX+CxT5oB5iTg/xml/EgmK/zaS0SywIgMfdnbOLYE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eG/63rQhZzFMwP79Bl39a3LyvWL7JYh9qiztrweLAXfe4kwl+IlTg/wscbKfEMSJBcsOUztteDYM01S/2Bs6w7E1CHNuVvFAFmGfgmYTU6UywLlXjHeQHL78K/GeAElYl4SKzazQhGms4/gtmVhUSpoMtu1aZ8Jqd1JfnYfk3M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IKj37K+J; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IKj37K+J"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47796a837c7so39115855e9.0
        for <linux-mmc@vger.kernel.org>; Tue, 16 Dec 2025 23:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765956280; x=1766561080; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9xgEHi6nG2DbxDSbxddMIGBB8cFpjoRGLXMH5Gvt9Ks=;
        b=IKj37K+JXyDo38yLXioolJzfrubbE2F2Bcg0o0HeuPsUGWzqqwTE+fMHNHfSSVzLRc
         B9jeAcmCyOG6qSlwjoi8R4F0RV/Yazu7E0tPMwqeIt4J+PPVloVxnNZ8Fi+rSxp5MUOg
         na+dVeiInP+wpXC9fo2vxzfYNjfC1oZihTushpHIDpVp6aUp38RQ6ky/MG/ATLXMt4CL
         U7MSbrzMZ4EpXkv+bblwuqq0oN0YpAjPPY/eVCciavxGgqWlbkLvdSF+gs7a1LTt/fDc
         Y50NaEinB6DGm29Chms/t9LtnRsiumHY9IPROzF0r9P0gFDXcIW+/vQxGJMZT8/N7ptf
         OwZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765956280; x=1766561080;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9xgEHi6nG2DbxDSbxddMIGBB8cFpjoRGLXMH5Gvt9Ks=;
        b=iU82Px4fkuWmkMGg87+0bFVu18rmtmiUnuADL/Ra+PvWOgXViVRlZUf0ZZfRY0FO+M
         w8puMr/X2YVtjgW1fQT5rq2OwzBPq3xjUZgwp4LYzxCvxaU5f58U6dPBibW3IB50G+5Z
         JugGB0dZWh6bf0QOfi351l6RfzV3X/8UEMk+qexG1EZqEnIDISYA028GEUpRrlNEIJoV
         LVIpi44P7yFXOH+RzbH7uA4IMgM9s51qwoeaDL++30qCHAN7Bjd0BHe08hX5QMrtbFDE
         VN58Ac+/ZLYBx3VXuAqE9cPBGOFcedyixxyl+bmfrqC+bp3X2ybdbmhlqF2G555JfLLv
         839w==
X-Gm-Message-State: AOJu0YxqDBoATRZuTvO1BfQsDGUJlcy6LlZu/XYywOQ5NIiTciRd9MGa
	GcH0pp/C04A2RlGwBi3JDAi+SOwoROlUShP+E23vi8Yt+/hp/9WRK/NQiejlaSsTkxA2B1MINVz
	4Zz8v
X-Gm-Gg: AY/fxX4+InbEaS+fBEBRP3TGcYRdM/sopXRA+0fyud/dBBKb7juBRhpacbVt+JvhxvY
	n7B+wDH6FlvAdr9tPTQ+1HlNN+lWakRE1MxBGmMNxOrp5cEG/bMU0CHcGCNR4o8zWtSL3bwGk6y
	HitEEt9/6nC0X211SR+muTI6wjTorlfnX163o9ly81QxIuG3aGT5ezoUHGX8hVoLm5gL3yVg7SG
	6GhGG6/jOtufc7rXW5RcCMjuW6qaO/gkexr/Ij4nEtmKKPLzoGGRKuZt3v3SlaYOPv96T+OAbxF
	ea+QyHUzRfBV5WRhvfGUWe++L+JFuJq2kgKjf4XmeW1Unfx3pdSJDrpk6vEeCi1yUz9Xe37nK+S
	NFiisUOtxBygl6B5dvP/dXOqlz4c6/1saVzQmZRsq+My1UDb2uQNL7jbi5KtcTG2aKouwmmdn0a
	a4yFvM/BzUpG5KKZ+j
X-Google-Smtp-Source: AGHT+IFA7HW51mCLo1q2WPdpUuT/RtahR2enKRIbRzpCWZPd4fh2TkGxmprp1sYJAbMytdxdS/5IdA==
X-Received: by 2002:a05:600c:8283:b0:479:3a2a:94e7 with SMTP id 5b1f17b1804b1-47bda747eccmr35589225e9.10.1765956280093;
        Tue, 16 Dec 2025 23:24:40 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47bdc1c2076sm24669635e9.3.2025.12.16.23.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 23:24:39 -0800 (PST)
Date: Wed, 17 Dec 2025 10:24:36 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-mmc@vger.kernel.org
Subject: [bug report] mmc: dw_mmc: add dw_mci_prepare_desc() for both of
 32bit and 64bit DMA
Message-ID: <aUJatHzP5fr1zvRF@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Shawn Lin,

Commit af7dde31afcc ("mmc: dw_mmc: add dw_mci_prepare_desc() for both
of 32bit and 64bit DMA") from Nov 26, 2025 (linux-next), leads to the
following Smatch static checker warning:

	drivers/mmc/host/dw_mmc.c:597 dw_mci_prepare_desc()
	error: uninitialized symbol 'desc'.

drivers/mmc/host/dw_mmc.c
    578 static inline int dw_mci_prepare_desc(struct dw_mci *host, struct mmc_data *data,
    579                                       unsigned int sg_len, bool is_64bit)
    580 {
    581         unsigned int desc_len;
    582         struct idmac_desc *desc_first, *desc_last, *desc;
    583         struct idmac_desc_64addr *desc64_first, *desc64_last, *desc64;
    584         u32 val, des0;
    585         int i, err;
    586 
    587         if (is_64bit)
    588                 desc64_first = desc64_last = desc64 = host->sg_cpu;
    589         else
    590                 desc_first = desc_last = desc = host->sg_cpu;
                                                 ^^^^

    591 
    592         for (i = 0; i < sg_len; i++) {
    593                 unsigned int length = sg_dma_len(&data->sg[i]);
    594 
    595                 u64 mem_addr = sg_dma_address(&data->sg[i]);
    596 
--> 597                 for ( ; length ; desc++) {

desc is only initialized for 32bit.

    598                         desc_len = (length <= DW_MCI_DESC_DATA_LENGTH) ?
    599                                    length : DW_MCI_DESC_DATA_LENGTH;
    600 
    601                         length -= desc_len;
    602 
    603                         /*
    604                          * Wait for the former clear OWN bit operation
    605                          * of IDMAC to make sure that this descriptor
    606                          * isn't still owned by IDMAC as IDMAC's write
    607                          * ops and CPU's read ops are asynchronous.
    608                          */
    609                         if (is_64bit)
    610                                 err = readl_poll_timeout_atomic(&desc64->des0, val,
    611                                         IDMAC_OWN_CLR64(val), 10, 100 * USEC_PER_MSEC);
    612                         else
    613                                 err = readl_poll_timeout_atomic(&desc->des0, val,
    614                                         IDMAC_OWN_CLR64(val), 10, 100 * USEC_PER_MSEC);
    615                         if (err)
    616                                 goto err_own_bit;
    617 
    618                         des0 = IDMAC_DES0_OWN | IDMAC_DES0_DIC | IDMAC_DES0_CH;
    619                         if (is_64bit)
    620                                 desc64->des0 = des0;
    621                         else
    622                                 desc->des0 = cpu_to_le32(des0);
    623 
    624                         /*
    625                          * 1. Set OWN bit and disable interrupts for this descriptor
    626                          * 2. Set Buffer length
    627                          * Set physical address to DMA to/from
    628                          */
    629                         if (is_64bit) {
    630                                 desc64->des0 = IDMAC_DES0_OWN | IDMAC_DES0_DIC | IDMAC_DES0_CH;
    631                                 IDMAC_64ADDR_SET_BUFFER1_SIZE(desc64, desc_len);
    632                                 desc64->des4 = mem_addr & 0xffffffff;
    633                                 desc64->des5 = mem_addr >> 32;
    634                         } else {
    635                                 IDMAC_SET_BUFFER1_SIZE(desc, desc_len);
    636                                 desc->des2 = cpu_to_le32(mem_addr);
    637                         }
    638 
    639                         /* Update physical address for the next desc */
    640                         mem_addr += desc_len;
    641 
    642                         /* Save pointer to the last descriptor */
    643                         if (is_64bit)
    644                                 desc64_last = desc64;
    645                         else
    646                                 desc_last = desc;
    647                 }
    648         }
    649 
    650         /* Set the first descriptor and the last descriptor */
    651         if (is_64bit) {
    652                 desc64_first->des0 |= IDMAC_DES0_FD;
    653                 desc64_last->des0 &= ~(IDMAC_DES0_CH | IDMAC_DES0_DIC);
    654                 desc64_last->des0 |= IDMAC_DES0_LD;
    655         } else {
    656                 desc_first->des0 |= cpu_to_le32(IDMAC_DES0_FD);
    657                 desc_last->des0 &= cpu_to_le32(~(IDMAC_DES0_CH | IDMAC_DES0_DIC));
    658                 desc_last->des0 |= cpu_to_le32(IDMAC_DES0_LD);
    659         }
    660 
    661         return 0;
    662 err_own_bit:
    663         /* restore the descriptor chain as it's polluted */
    664         dev_dbg(host->dev, "descriptor is still owned by IDMAC.\n");
    665         memset(host->sg_cpu, 0, DESC_RING_BUF_SZ);
    666         dw_mci_idmac_init(host);
    667         return -EINVAL;
    668 }

regards,
dan carpenter
