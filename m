Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04BE19DF8B
	for <linux-mmc@vger.kernel.org>; Wed,  9 Oct 2024 14:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728484541; cv=none; b=TNRRhOZIqn7ty8iVa1dVD6DOA65PTMRyc7d4p2oMSHUeu1+OkLCG4tucdrODsUdNz+T4S6FLTqS38ZigbttYP7KGRc7OqWBYDTMKo0BJCBLjwLhLJvYKzM5q/BGwVn1KDjtMCKrUhNVtzBelhqWPo7UzijHPsRX4y+itytFlGRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728484541; c=relaxed/simple;
	bh=EaLXnfhHW4aZJ49EyFJn6y0ELYH45hIZmKajoGbTyDw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=thcu/Do6hKB4GlCGUOwPehMm8SzevvPqzB1/8+pJGr/x5Nxs5q/JNZbzwEj7Yq8LflLs8d7RjlOMJkxMqVQETKk54tTNTd3vU/r/cMV2sFDoUe4YqYrEMsi4fahjATp0FGV84mQBtj4Ko+hees9jlGmOszXF657L6/hKgSeElxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JQAPysvq; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JQAPysvq"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43056d99a5aso6217355e9.0
        for <linux-mmc@vger.kernel.org>; Wed, 09 Oct 2024 07:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728484538; x=1729089338; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a62x9KJA8wlODVmueEUjykm5dSzZ+5fvoomALzAUqD8=;
        b=JQAPysvqxnJZvQK/pitWW70TvT6VVdHWSiDmf89t7P7VrZ6k22Droeq4Izx0t03e5t
         BS8aD6xJahlJiNqyAfp+MD5gbgnPlYM+dJN7J+doYfHRSTNQvktJNiXzMQHq3yPpcy0G
         bE7rxO8iHxfhSCd9yViXaoQ0wOjVtaPdpc/KVblI9VbjSXCM+bzjkR9SriS8QLIMMGgT
         3gm9+wzYc4D5/1dQ845QknMiibLav9prWVZ/3C9F9EGHCJ0cM+1N7JITW1NwRMDH1qx+
         yoz5DNnrclag8SPv0miUCunHpDpiFSptpcLahwi8Nc8v2hMZTjoltiQxe1iq7w6vsLYa
         +KFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728484538; x=1729089338;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a62x9KJA8wlODVmueEUjykm5dSzZ+5fvoomALzAUqD8=;
        b=qua4o7mRSlz+P1m4MLPwkYAXxd/hjA5zvA/Qj6utch5G2qP4D0cTtvrzloKKmPZfEq
         k2PzRIZ2L36wliRLO/QYT0T1UUHklza/VZnCt8j5GYzhYVoanQwmh8XZroaa4dkW/HoF
         jhTNUYGMrAG403jWlblNfqrdYqna8inGAZLrMrjPgusvPGSNPNEUv5ifJHM6SeAAHiia
         HtT4XAQqYtfyldLlArTrUVV78Q3+7/qZO40B0ViwJOs3xEpu2B7uFQZqpcByMHmc1Ufc
         RG0qGpk92ZEq6MtO1fYw0bSv+DRb1C/zmL7aGIZIARMDn0Jex/Fg7Zv0j76n21e/Vkqd
         W86Q==
X-Gm-Message-State: AOJu0YxFmBXDQCjEDxOt1NdI0BgFxhsxM5CjDz0WH3Dtwh7QX3r1KjTr
	juQPOX+hKMiHGholXZCy8B95M4AoG4X9iPuLk8awju+fg5H8yxUdECCiGaCsG3WgT1pdXy8gnVN
	u
X-Google-Smtp-Source: AGHT+IErDEg/wvC0csxgBR1wDqOnmnw2Qa1n0NX0jN+uAtAWWxsafJ/BC5+LgcaDIkvatztUnvdkrw==
X-Received: by 2002:a05:600c:1c8d:b0:42c:ba81:117c with SMTP id 5b1f17b1804b1-43069973a85mr20143305e9.6.1728484537909;
        Wed, 09 Oct 2024 07:35:37 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430d59b1207sm21897945e9.31.2024.10.09.07.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 07:35:37 -0700 (PDT)
Date: Wed, 9 Oct 2024 17:35:33 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Avri Altman <avri.altman@wdc.com>
Cc: linux-mmc@vger.kernel.org
Subject: [bug report] mmc: core: Add open-ended Ext memory addressing
Message-ID: <345be6cd-f2f3-472e-a897-ca4b7c4cf826@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Avri Altman,

Commit 737d220bb2be ("mmc: core: Add open-ended Ext memory
addressing") from Oct 6, 2024 (linux-next), leads to the following
Smatch static checker warning:

	drivers/mmc/core/core.c:358 mmc_start_request()
	error: we previously assumed 'mrq->cmd' could be null (see line 339)

drivers/mmc/core/core.c
   335  int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
   336  {
   337          int err;
   338  
   339          if (mrq->cmd && mrq->cmd->has_ext_addr)
                    ^^^^^^^^
The patch addes this NULL check

   340                  mmc_send_ext_addr(host, mrq->cmd->ext_addr);
   341  
   342          init_completion(&mrq->cmd_completion);
   343  
   344          mmc_retune_hold(host);
   345  
   346          if (mmc_card_removed(host->card))
   347                  return -ENOMEDIUM;
   348  
   349          mmc_mrq_pr_debug(host, mrq, false);
   350  
   351          WARN_ON(!host->claimed);
   352  
   353          err = mmc_mrq_prep(host, mrq);
   354          if (err)
   355                  return err;
   356  
   357          led_trigger_event(host->led, LED_FULL);
   358          __mmc_start_request(host, mrq);
                                          ^^^
But if mrq->cmd is NULL the __mmc_start_request() function will crash.
Hopefully, we can just remove the NULL check.

   359  
   360          return 0;
   361  }

regards,
dan carpenter
