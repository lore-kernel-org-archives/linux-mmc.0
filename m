Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foundries.io header.i=@foundries.io header.b="DV3hmUIO"
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E43310FC
	for <linux-mmc@vger.kernel.org>; Fri,  1 Dec 2023 06:24:17 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40b5155e154so18870965e9.3
        for <linux-mmc@vger.kernel.org>; Fri, 01 Dec 2023 06:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries.io; s=google; t=1701440655; x=1702045455; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cnm9xET3gpVMzAmdfqU6W57IEJsB01S0uHawBahzWkw=;
        b=DV3hmUIOSngEeQ3dSL71MQ35B85JYTr9I8k2h0kY3xJkFxt3CFuD759C0BC5nf704k
         y1gTZbRk3UCicp0pZpj/N9HPMnDCBUtf1Nk8uB+5HaIyqJhptTMwT6LHcKEg91rrP/RB
         69iOTrFjEdbrzHrxjOZdTc8nS/rVGXwMK98vxUAMixUl8bURdIlextLfoPm4HWIQllsp
         sQcMIzuMOw3OgsNtpKrhvrzNyVQAGe9uAul48H24z1EccgOrBXsP6fXIhsh3nHKY9vhK
         foJA9YqlJBHvAJEeMhwvWBOIjRHN4RbqO4463u8kqJ2um63/kB6PohdrRh9lge0RRWra
         f+4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701440655; x=1702045455;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cnm9xET3gpVMzAmdfqU6W57IEJsB01S0uHawBahzWkw=;
        b=Vbnc1ixjXgDnRFF9vVutsLOfZUCx/FZAo3cbAQyS2IFjcQHTbj1neLAgOvAXJ7eCLP
         tcHqGSSNik7PxlENkuPcEaXPRGHCOpbNZHfHAZuh76jjDB090WorfJVMF2YdHtTa7DNr
         On8C6LvJf9ZFvJF7Kkt/prabjTQej+LrDCudjh+1mSZheY/mNxpG9meeRINXWiLI8L+/
         Y0z+NDMYhCB4W5lCDmF90GItp+eFbd5I+ImxvuN6d5dTdCwBth3u2QxYQdMHF2wrH/Oi
         hVW7kVMWAMVDPOx19R7pmngfIyop4coV0ZcMjJEMjo1Sca7Yvb88XUfs9mlZ0Qr9sPLo
         Sa5g==
X-Gm-Message-State: AOJu0Yx5RPK4osaSQMzOVKlkpedhqbopySQVI6d8Dw40k8KFNgDDMoFh
	TRwTICVX+w27EP+AEP1KRlaU6w==
X-Google-Smtp-Source: AGHT+IGNNaq3UP5sr8OqTdBrASWUv4MmGK4cL0MmkCYZTInNUfnB6b8yDBt3/PpTsEps3mVTFxBteg==
X-Received: by 2002:a05:600c:5008:b0:40b:5e4a:40da with SMTP id n8-20020a05600c500800b0040b5e4a40damr321477wmr.250.1701440655573;
        Fri, 01 Dec 2023 06:24:15 -0800 (PST)
Received: from trax (139.red-79-144-198.dynamicip.rima-tde.net. [79.144.198.139])
        by smtp.gmail.com with ESMTPSA id j11-20020a05600c190b00b0040b47c69d08sm9218703wmq.18.2023.12.01.06.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 06:24:15 -0800 (PST)
From: "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
X-Google-Original-From: "Jorge Ramirez-Ortiz, Foundries" <JorgeRamirez-Ortiz>
Date: Fri, 1 Dec 2023 15:24:14 +0100
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Jorge Ramirez-Ortiz <jorge@foundries.io>, ulf.hansson@linaro.org,
	linus.walleij@linaro.org, adrian.hunter@intel.com,
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCHv3] mmc: rpmb: fixes pause retune on all RPMB partitions.
Message-ID: <ZWnsjtnag6gXDnuq@trax>
References: <20231201100527.1034292-1-jorge@foundries.io>
 <2023120139-untried-unholy-456e@gregkh>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023120139-untried-unholy-456e@gregkh>

On 01/12/23 12:22:57, Greg KH wrote:
> On Fri, Dec 01, 2023 at 11:05:27AM +0100, Jorge Ramirez-Ortiz wrote:
> > When RPMB was converted to a character device, it added support for
> > multiple RPMB partitions (Commit 97548575bef3 ("mmc: block: Convert RPMB
> > to a character device").
> >
> > One of the changes in this commit was transforming the variable
> > target_part defined in __mmc_blk_ioctl_cmd into a bitmask.
> >
> > This inadvertedly regressed the validation check done in
> > mmc_blk_part_switch_pre() and mmc_blk_part_switch_post().
> >
> > This commit fixes that regression.
> >
> > Fixes: 97548575bef3 ("mmc: block: Convert RPMB to a character device")
> > Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
> > Cc: <stable@vger.kernel.org> # v6.0+
>
> Why only 6.0 when the "Fixes:" tag goes back to a 4.14 commit?


ops so sorry (was WIP and got distracted press sent and forgot), will
fix and add Linus' Reviewed-by.



>
> thanks,
>
> greg k-h
