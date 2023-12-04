Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foundries.io header.i=@foundries.io header.b="Q/1b4G9J"
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F4F83
	for <linux-mmc@vger.kernel.org>; Mon,  4 Dec 2023 05:58:15 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40b397793aaso27661825e9.0
        for <linux-mmc@vger.kernel.org>; Mon, 04 Dec 2023 05:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries.io; s=google; t=1701698294; x=1702303094; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1Wn71OJAsHrUsi0hi6qKz41BqzfeWUDfsnSD1MArV6Y=;
        b=Q/1b4G9Jbcgp4blJSRV8N8/MiGLqKz6vACPg/45GSn0lbbVI7jpJ+RcXUGHTipmB2n
         jdxZtzHvmJeBWVUqfsySdrz+pJRBloYP67Z6LdVCu8jv48nDwe8b5BczRyqhFQ8ONy8F
         j+IwCbQVJTYJE7pCAvasUEMOUqSiO0KUYBeHSiC9vd26h/e1Ovpchy7xFJfZQEyjrUv/
         mmRgZfck/kbiC3XyRygUxUGwXYQ4Dm6dxO04RwvaeYT8XAPfgDK7mWlFejORnMsdMXBO
         wUnh09tf8oz9joIDKz4WorOrOIq4u2NjnW1ad3UNlQanbO7GjQyOcn0YPkRB30muTg/v
         ylPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701698294; x=1702303094;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Wn71OJAsHrUsi0hi6qKz41BqzfeWUDfsnSD1MArV6Y=;
        b=g1NCKcKK4bVCoLPG+I2+gr0RewSvsWt9h0ZdMayd5uuPavuULxb5ciEgXmXKTpIrQc
         nHmBYjb93VmTpSmHnqBsmiKODEOGW61Pm0C3hn9+k5P3aYMNC7/w+pLJg9JWvRDBL58+
         UutNkPVI6SR958eHE4ACdbU4BLXfrQY54yprIuu028MqTtlp7g6YBzTWnu5Co7y1hlry
         zQzO4LsFkZMI4jiBEYoL1iQO1BAo1+M2GAMix+YkyhpWTRNNZPfHc52L2vNSAOJXnSvH
         LTr1/fnD3PuWmJE3jfXdNleD7/dk7hplpPLXq3b32d2qf4jZpw9sQhLVqOuPVTF6MqLT
         N7Tg==
X-Gm-Message-State: AOJu0YwVyCyhAuQ6GOogXM5KQEwyxnavs7vGg9aXwOZYpIJwrO9Gx+GI
	FtDtELs5icd3LGWlVq/bUBoORw==
X-Google-Smtp-Source: AGHT+IFeAAaNKjmvQvyhXB/RWQ1dcGIG/iQq6n7LDgKtxGw4htbGbrcJ1cjYN0N4sspWHS2O6S8Peg==
X-Received: by 2002:a05:600c:348a:b0:40b:5e26:2379 with SMTP id a10-20020a05600c348a00b0040b5e262379mr3046913wmq.42.1701698293953;
        Mon, 04 Dec 2023 05:58:13 -0800 (PST)
Received: from trax (139.red-79-144-198.dynamicip.rima-tde.net. [79.144.198.139])
        by smtp.gmail.com with ESMTPSA id r11-20020a5d498b000000b0033339da02f9sm6773310wrq.110.2023.12.04.05.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 05:58:13 -0800 (PST)
From: "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
X-Google-Original-From: "Jorge Ramirez-Ortiz, Foundries" <JorgeRamirez-Ortiz>
Date: Mon, 4 Dec 2023 14:58:11 +0100
To: Avri Altman <Avri.Altman@wdc.com>
Cc: "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"CLoehle@hyperstone.com" <CLoehle@hyperstone.com>,
	"jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
	"hare@suse.de" <hare@suse.de>, Ulf Hansson <ulf.hansson@linaro.org>,
	"beanhuo@micron.com" <beanhuo@micron.com>,
	"yangyingliang@huawei.com" <yangyingliang@huawei.com>,
	"asuk4.q@gmail.com" <asuk4.q@gmail.com>,
	"yibin.ding@unisoc.com" <yibin.ding@unisoc.com>,
	"victor.shih@genesyslogic.com.tw" <victor.shih@genesyslogic.com.tw>,
	"marex@denx.de" <marex@denx.de>,
	"rafael.beims@toradex.com" <rafael.beims@toradex.com>,
	"robimarko@gmail.com" <robimarko@gmail.com>,
	"ricardo@foundries.io" <ricardo@foundries.io>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv2] mmc: rpmb: add quirk MMC_QUIRK_BROKEN_RPMB_RETUNE
Message-ID: <ZW3a8xneptC6y/N8@trax>
References: <ZWkGZ7av1S4Clwdv@trax>
 <ZWkKgU+J9atnJdqT@trax>
 <ZWmN+k+wUWcXT5ID@trax>
 <fecd033b-b2ea-4906-a320-22a5c2ede46c@intel.com>
 <ZWoBqs/5m6tCuBGo@trax>
 <ZWoTOm+8Y75TLz6q@trax>
 <DM6PR04MB6575FF9532A9FC0EE91B5B37FC80A@DM6PR04MB6575.namprd04.prod.outlook.com>
 <ZWysTPapFyGJdu5d@trax>
 <DM6PR04MB6575F9EB1C3309F64EEE6BCCFC86A@DM6PR04MB6575.namprd04.prod.outlook.com>
 <DM6PR04MB6575127DFCEC4C178F7E33B7FC86A@DM6PR04MB6575.namprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR04MB6575127DFCEC4C178F7E33B7FC86A@DM6PR04MB6575.namprd04.prod.outlook.com>

On 04/12/23 12:59:07, Avri Altman wrote:
> > > We could carry the patch internally (it seems harmless after all the
> > > testing
> > > done) but I'd much rather land it upstream if possible.
> > Agreed.
> Also, I am totally fine, and maybe it's even better, with adding this as a default behavior for all vendors.
> I see no point in those tunings while accessing rpmb anyway.
>

I'll repost then without the quirk.

In fact just this morning - I was about to update -  I was able to test
on an early board revision with a different eMMC module (at the time
RPMB wasnt validated) which upon reflashing also exhibited the issue

see below:

# cat /sys/class/mmc_host/mmc0/mmc0\:0001/csd
d02700328f5903ffffffffef86400000

# cat /sys/class/mmc_host/mmc0/mmc0\:0001/name
064GB2

[  218.759036] sdhci-arasan ff160000.mmc: __mmc_blk_ioctl_cmd: data error -84
E/TC:? 0
E/TC:? 0 TA panicked with code 0xffff0000
E/LD:  Status of TA 22250a54-0bf1-48fe-8002-7b20f1c9c9b1
E/LD:   arch: aarch64
E/LD:  region  0: va 0xc0004000 pa 0x7e200000 size 0x002000 flags rw-s (ldelf)
E/LD:  region  1: va 0xc0006000 pa 0x7e202000 size 0x008000 flags r-xs (ldelf)
E/LD:  region  2: va 0xc000e000 pa 0x7e20a000 size 0x001000 flags rw-s (ldelf)
E/LD:  region  3: va 0xc000f000 pa 0x7e20b000 size 0x004000 flags rw-s (ldelf)
E/LD:  region  4: va 0xc0013000 pa 0x7e20f000 size 0x001000 flags r--s
E/LD:  region  5: va 0xc0014000 pa 0x7e22c000 size 0x005000 flags rw-s (stack)
E/LD:  region  6: va 0xc0019000 pa 0x80dc4e298 size 0x002000 flags rw-- (param)
E/LD:  region  7: va 0xc001b000 pa 0x80dd1c298 size 0x001000 flags rw-- (param)
E/LD:  region  8: va 0xc0091000 pa 0x00001000 size 0x014000 flags r-xs [0]
E/LD:  region  9: va 0xc00a5000 pa 0x00015000 size 0x008000 flags rw-s [0]
E/LD:   [0] 22250a54-0bf1-48fe-8002-7b20f1c9c9b1 @ 0xc0091000
E/LD:  Call stack:
E/LD:   0xc0093a14
E/LD:   0xc009131c
E/LD:   0xc0094d40
E/LD:   0xc0091624
Read persistent value for bootupgrade_available failed: Exec format error
Cant print the environment
Error: fiovb_printenv command failed. Exiting.

> Thanks,
> Avri
>
> >
> > Thanks,
> > Avri
> > >
> > > >
> > > > Thanks a lot for fixing this,
> > > > Avri
> > >
> > > thanks everyone for the support.
> > >
> > > >
> > > > (btw - yes - our manufacturer id is 0x45 - it is set differently in
> > > > the mmc driver for historic reasons - Thank you for adding this.)
> > > >
> > > > >
> > > > >
> > > > > >
> > > > > > >
> > > > >
> > > >
