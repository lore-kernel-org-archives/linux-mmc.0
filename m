Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF646D1A8
	for <linux-mmc@vger.kernel.org>; Thu,  8 Feb 2024 10:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707387361; cv=none; b=EbEIVJPpVqLzMtViomJCCdqRHMI8fTH0w9QBjEjYNkm60b/ZUnZUPg/lhSJuPb5q0McLOU2Kvj2+LAiisdK02oJj5TTNkYHR6X7eVbGSBlnLMqmGY/sdCSP822YIhBaLOwzANSN5r8YzBJfXMEbS1ukfGGWcvCJ9KLvDVkkXO6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707387361; c=relaxed/simple;
	bh=wWmGI5tZG2P8IH7ihOEYo2e78tNqbmXlxXlGNN8tImE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=vAFHV40RtRKcXYYCtp5DFbMy5vQ0trEa5FC7nd5ThjScbgRUWwrOcYE+L2HJsHSxSsDrrAV9B4kLq8V6yOYKbdS5M2Sy1pjjsGnTagLErQkdZHHyenNIM29SDcvdzP0QEzboBJtR95koct5vNDDK5gl2eb0B/jjNyf5QekF1pns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=N+ORxBoK; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N+ORxBoK"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a3bbad234feso18176766b.0
        for <linux-mmc@vger.kernel.org>; Thu, 08 Feb 2024 02:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707387358; x=1707992158; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jH4bJbzV1Nelq6h1EwlmCainpWdSY+zm7Xx803mK3wQ=;
        b=N+ORxBoKbeuKb4BVQeqftyLREO9aN7fGgnxxQDCf8BZvXFCV2W97rR5vsZk1GvOyoq
         KctvjT/jp/uPpKqmQMGjn0AbA/Ju+NosvGUgbmlGQWot1iscf7uwd/UvDhK5xBG7GWrs
         CPDl/1qcata0ZXbnpV0UFGbzs3uD+M1IAumZMAz8SaOyqnsuis7xbvWkv25lBuxLgr4O
         x+W0KNJQW2QEuUy+iQLrmGh6ZgFPOS4GTxXqgEdkGCvydQxdNqrdO/wCHF77qyomwXeU
         DqxsHJTth3WoL2pH/W+hkQsSp/kz591ceJxqJCQKognOdIXVwI+wC9Zl89nJi0KNmYTa
         PoFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707387358; x=1707992158;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jH4bJbzV1Nelq6h1EwlmCainpWdSY+zm7Xx803mK3wQ=;
        b=msZMmUiT0CVqHEtFmSXPmoFzvIYJaN5nEFdb2M06l1rtAzJ9aSgk9u5xj74OJTZP5E
         7NauXtsgLL4yyzbUM06LJNxl9miCM7iO+Xzb5Mx1RzJMs3xD3v+DjNitmXlYN3F5aB4O
         djKScn6GEvASZUUAAa405BoSTUB/L9EVjcN5TLWpYDnJIjaoMyRRzTSST8GpRB69Zqgl
         ezGwKVVDnLoF5lgJKRa4Ej6h1FxsFh7LfyvLX7fA+cEPgZrFfKDsYrj/Cif0Twnb0x2p
         GdrU0cK6wnoE1PpUazgqSq+xXTLZMg6b7kgPfRpMzjcQTK8fDzeCA1HcD7zZcdljTTt+
         qQ1A==
X-Forwarded-Encrypted: i=1; AJvYcCUOT3l+ZvOIlMNwh8ZSZIMnl+heaUV7hHiS71622um92BnU+5sEMTWbSYwGxTCdA/grAAI9Y87a0778YVPNZG8f+mGsUmq7gQNd
X-Gm-Message-State: AOJu0YxQu+5BQU8y5ySH+lZ83FbRCKH5RpmcMnvycTGPl6bHaB4HvR93
	PrqYuztEoOiIaxZ8oz0RHypatsDUUMpkdOQir6d5YlWBASj242+lbcqvS+OpJW2qZdCSrU0RqKN
	N
X-Google-Smtp-Source: AGHT+IFhYSFGR5ljhdKF/XFxUw2ra8/x3jR5BcMqyICrrP9bb6dBsnECjuWXDdOUUFfEDBYsYtTwBQ==
X-Received: by 2002:a17:906:1ecc:b0:a37:6aa8:6885 with SMTP id m12-20020a1709061ecc00b00a376aa86885mr6141221ejj.19.1707387357691;
        Thu, 08 Feb 2024 02:15:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXetXVGqH4KUKyruubya4GzkXBojO1WknszDBw+w3ahCSSkdwyGRCj8l4GB10lGNGT5jxe9uQU2vB8TC+4+1uKPYORgcBZW33xpYum9tp29on/PaeiXkMyYv9GSM7fDNSd6ZF4=
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id vo7-20020a170907a80700b00a37fbee48f8sm1724189ejc.133.2024.02.08.02.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 02:15:57 -0800 (PST)
Date: Thu, 8 Feb 2024 13:15:53 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: manfred@colorfullife.com
Cc: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: [bug report] genirq: Add might_sleep() to disable_irq()
Message-ID: <be6e9b02-0fe6-4731-bf0e-4691e2cd99ad@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Manfred Spraul,

The patch 17549b0f184d: "genirq: Add might_sleep() to disable_irq()"
from Dec 16, 2022 (linux-next), leads to the following Smatch static
checker warning:

	drivers/mmc/host/omap.c:647 mmc_omap_cmd_timer()
	warn: sleeping in atomic context

drivers/mmc/host/omap.c
    638 static void
    639 mmc_omap_cmd_timer(struct timer_list *t)
    640 {
    641         struct mmc_omap_host *host = from_timer(host, t, cmd_abort_timer);
    642         unsigned long flags;
    643 
    644         spin_lock_irqsave(&host->slot_lock, flags);
                ^^^^^^^^^^^^^^^^^
Holding a spinlock.

    645         if (host->cmd != NULL && !host->abort) {
    646                 OMAP_MMC_WRITE(host, IE, 0);
--> 647                 disable_irq(host->irq);

Manfred's patch just exposes the bug, and doesn't cause it.  However,
disable_irq() is a might_sleep() function now.

    648                 host->abort = 1;
    649                 queue_work(host->mmc_omap_wq, &host->cmd_abort_work);
    650         }
    651         spin_unlock_irqrestore(&host->slot_lock, flags);
    652 }

regards,
dan carpenter
