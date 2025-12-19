Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6F9308F36
	for <linux-mmc@vger.kernel.org>; Fri, 19 Dec 2025 08:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766132246; cv=none; b=G6dxkSyNjHwIHfl1Q0KP8eUf4r6XnP5YDfi1K9IcZMtrlB0Txj2zbnhJY38iP8GFoFaYQvZtx7aaIh7/hw4l1PTuCywkGraAw7UXX89DuR6lzPAoAcXYsLz864pFcbOiw4C+zt3OOCuZMoTkdOsf0WOZeKeIQZt0cMidqoL+wcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766132246; c=relaxed/simple;
	bh=lsarIcT4DVX1A0cRUANhJmJB4+VG863EPubDmOxlKzk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TRF8uQdaFZKprJBe0C0MPS3MZDaEsykLEWpvK02JOOFrHshmCrHkNWODui1znDID4xgWfFmQqIQ98ePWjue5nLhcP3Fd7H/in0D2ULQC/qd5RWTYrFGeGqT4qZRYgtG8IG0eCAzCoMho2lbsZca+6FQ8B1KgxuiVw5SFPive6Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aoOkgRXr; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aoOkgRXr"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4775ae77516so14387225e9.1
        for <linux-mmc@vger.kernel.org>; Fri, 19 Dec 2025 00:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1766132243; x=1766737043; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FdqXQ/GDNVcc+0mBwiuJrB6xIRzDqi7BqAG3B5ju4TA=;
        b=aoOkgRXrnV+8vsJClQjIXRDVi4hU7u/eAS8LLv3yNP23uwL5YsZr3To15ATrTKCUJg
         cxTrB/qGGNl+dmq0nYI08m7KxO0Hw+gy/gthHyeetFk6WnVRhpxZDY9HaIpoxP3PF+aI
         EhQZ3zrJEk/88XNLE69A6N3PW1dx6otf0xHQOTLfwbR9bTGXfkuiWf8IWOeWLvnAQ9vL
         ZWkD/2aeAB4nfGCPOwkKyyZIr2MR3IwGRSEp4BZluYQpVGUGnuIWoQfsr2ITBIhGxUDj
         jA1DD2twCedpWhxaONACLJybhVoPZccHpF5nntQtH3pH3mXmgpS6SZxNDGPcPXJiYRhA
         jo5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766132243; x=1766737043;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FdqXQ/GDNVcc+0mBwiuJrB6xIRzDqi7BqAG3B5ju4TA=;
        b=Dx15O55oUoulG9QMRA6vvPAx7XW0rcxNo3okQdpTSLRPq52pBtHFAnb/vhna9o4Qlk
         d5yS+RVj3PHksM6Pi94Lutx6XLk9GZLaoK8Q45UbGt1glYLpxWtttUDsb5D7v/Yi4Q58
         DDJ0vSradLz7081IV5pAcvSZF+dhGZ57MAxxOLaU+z4JdMJlK1HpznbOUZ7vhgqRPERj
         opxtwXYa5zaaq8bAEmEetCAneGQ+SZie6zAL8N9Mhw6hNv20Yy0YOWiwhXu2HcRDRAIf
         n8et+DXdmBSrCDqcxBUAIBTCVRIghwCN5VdLJqpz5G6Fo/GLXw6OpMhKhSLOtrCK5XM5
         dPVw==
X-Gm-Message-State: AOJu0Yya2nwm3A8+PDGxPjqDPJzpf0S9gwEwkNqT65L0auqV7yWlwcW4
	YAjIZMlUxPXo/+qhFZrgBre13TIZeQVPW2JcNqxfkF+QOjbA53FXgRZ8yX0WoipiGtg=
X-Gm-Gg: AY/fxX41GJ4WHb2kYhK57X7vI3Wj52vHyBixvc1BTK4wQxMxBZI+wJOaiChZL6bzRwz
	sF/Czmw2+QkTppRHXS2juAXycwHdvphZbyZHS/KcfBnRLc+YKTHUuPe7VEJBYoI1buMATpykVgp
	bOSKfBQEur/ScqKHAHU8fYH2P4vFyLx8GesJQpxAQ7TadaYZKW+k+9EctPPXUqWXX+FRAL3QCG4
	2+JqbqIueDDzIZNVZ6SNXipVDLGs7xDdtlBwRhkw+rVKDDSxs7cAewFoNI9amhltciAtqigHvoJ
	DF867FnoUDKWAa/R8et4eK8O/59F8oTVTx6Ul6nqzDFy4/TLtbms9RzHnnf/OES2l89dndnMEyI
	30hfk9b2p9MIxg2M7grMWoNSORO7uxYhB7Gm+brRV7cle74BgAPPAKVCtqKnkQ1oQ8xychFkLkU
	K50gvT3a5l80v7Tkxw
X-Google-Smtp-Source: AGHT+IEy6t44mkC7xYhcb15vtLs8VusV/RxOKQ9KEMjCv1p/5NGj+n8QqHyAhng2jwt8lZd0d7gt6A==
X-Received: by 2002:a05:600c:8484:b0:477:b642:9dbf with SMTP id 5b1f17b1804b1-47d195c1cebmr17818775e9.32.1766132243076;
        Fri, 19 Dec 2025 00:17:23 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be279c5f8sm80846885e9.9.2025.12.19.00.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 00:17:22 -0800 (PST)
Date: Fri, 19 Dec 2025 11:17:19 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-mmc@vger.kernel.org
Subject: [bug report] mmc: dw_mmc: Remove struct dw_mci_slot
Message-ID: <aUUKD0YbuIIcK5pT@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Shawn Lin,

Commit 926311cf3361 ("mmc: dw_mmc: Remove struct dw_mci_slot") from
Dec 16, 2025 (linux-next), leads to the following Smatch static
checker warning:

	drivers/mmc/host/dw_mmc.c:3467 dw_mci_remove()
	error: we previously assumed 'host' could be null (see line 3464)

drivers/mmc/host/dw_mmc.c
    3457         return ret;
    3458 }
    3459 EXPORT_SYMBOL(dw_mci_probe);
    3460 
    3461 void dw_mci_remove(struct dw_mci *host)
    3462 {
    3463         dev_dbg(host->dev, "remove host\n");
                         ^^^^^^^^^
Host is dereferenced

    3464         if (host)

Then checked for NULL.

    3465                 dw_mci_cleanup_host(host);

The dw_mci_cleanup_host() function gives up our claim to host which
allows it to be re-used.

    3466 
--> 3467         mci_writel(host, RINTSTS, 0xFFFFFFFF);

So it's surprising to me that we keep on using it throughout the
rest of the function.

    3468         mci_writel(host, INTMASK, 0); /* disable all mmc interrupt first */
    3469 
    3470         /* disable clock to CIU */
    3471         mci_writel(host, CLKENA, 0);
    3472         mci_writel(host, CLKSRC, 0);
    3473 
    3474         if (host->use_dma && host->dma_ops->exit)
    3475                 host->dma_ops->exit(host);
    3476 
    3477         reset_control_assert(host->pdata->rstc);
    3478 
    3479         clk_disable_unprepare(host->ciu_clk);
    3480         clk_disable_unprepare(host->biu_clk);
    3481 }

regards,
dan carpenter
