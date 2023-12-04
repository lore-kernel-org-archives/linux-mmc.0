Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foundries.io header.i=@foundries.io header.b="CRBUcKnu"
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86F2FA
	for <linux-mmc@vger.kernel.org>; Mon,  4 Dec 2023 10:10:07 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3316bb1303bso3639234f8f.0
        for <linux-mmc@vger.kernel.org>; Mon, 04 Dec 2023 10:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries.io; s=google; t=1701713406; x=1702318206; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rZbWCVcXU9/MRhjYwkods3ysAycuirphkwAN5EQWtwo=;
        b=CRBUcKnuK/v8/g6bh2cASELfkgKCjLnfWpRY1xdSNiJPA0K7JYKGpjEi2yDX7UUhxt
         XZHnTJqF5BNmRdg7u87zNQ/VbwmBKLx8z3VUu+pvF2zc7Nf6TIici9AD9kqmCj2NS/pv
         MD7NmExUHPAhUY5aOXnQKZWud1JYJqK+E4u+6QttGCiQpZEHZLZ8AVbIYPiGDrIyboAT
         Oa5yaJg49Z4EnC2d2tTiVVw9WxTcvcBkEBu32nESsdPZqs2khBCtrKJeKahWONPZmI9o
         fx7ENu//WCnsE2WPf4HUs7Z8ZHAechPIDuzhScTd3HBvJQWJPvdCmYfw7VGeXMhj40P7
         uYKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701713406; x=1702318206;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rZbWCVcXU9/MRhjYwkods3ysAycuirphkwAN5EQWtwo=;
        b=meqMlVwdfomcgxguuth3LdrbCNEG+5u9finrQuCqsQFyq5TLoiM5qr4+jS3weSnEuP
         K7IYj9t82S5tcCrtsDIy7ToqQvKHsjYAyHOMv8jyF9JUeiLncHdI+e6kBKk0c8Tb3cLt
         j4REGFA1gJlv0IyKiZzs3ZCY3SOj7sNLbFo8lUKrx5TiwqCc9arNpNEB9QLvmTOd/kE8
         +6mkJOF+1Kax0YCv9IzqTtxfym1RqyEhA+vdsMik2iajB196iix2jh5H6/RrbwRlERji
         h64FNi/WDmYI9IUhresinYShfk4RzxhRkg2znOfv2eBEHH8P0FCDPhoz5iKZ6sMaD6k0
         ZaMA==
X-Gm-Message-State: AOJu0YyUWr7O9rQCiwGE462mZOUA6GScMsrB7YijdZBeR24yzIad+i3o
	mkiaK/2U1abJgmOJG3s2haFzkg==
X-Google-Smtp-Source: AGHT+IEu42sDOAHu0Uvi4OF+0kwVgMPrqbelTZJYNOhX/EuGwVOVKYaPYLCCf0d7tIEtl5tFP0jZYA==
X-Received: by 2002:a5d:4b10:0:b0:333:85e:a11c with SMTP id v16-20020a5d4b10000000b00333085ea11cmr3194646wrq.16.1701713406280;
        Mon, 04 Dec 2023 10:10:06 -0800 (PST)
Received: from trax (139.red-79-144-198.dynamicip.rima-tde.net. [79.144.198.139])
        by smtp.gmail.com with ESMTPSA id cg16-20020a5d5cd0000000b003332656cd73sm11721629wrb.105.2023.12.04.10.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 10:10:05 -0800 (PST)
From: "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
X-Google-Original-From: "Jorge Ramirez-Ortiz, Foundries" <JorgeRamirez-Ortiz>
Date: Mon, 4 Dec 2023 19:10:05 +0100
To: Christian Loehle <christian.loehle@arm.com>
Cc: Jorge Ramirez-Ortiz <jorge@foundries.io>, Avri.Altman@wdc.com,
	adrian.hunter@intel.com, ulf.hansson@linaro.org,
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH] mmc: rpmb: do not force a retune before RPMB switch
Message-ID: <ZW4V/XzXY114l5/a@trax>
References: <20231204172243.3382495-1-jorge@foundries.io>
 <9747ebb3-98e6-47da-8a9b-9b7dcf7909f6@arm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9747ebb3-98e6-47da-8a9b-9b7dcf7909f6@arm.com>

On 04/12/23 17:52:24, Christian Loehle wrote:
> On 04/12/2023 17:22, Jorge Ramirez-Ortiz wrote:
> > Requesting a retune before switching to the RPMB partition has been
> > observed to cause CRC errors on the RPMB reads (-EILSEQ).
> >
> > Since RPMB reads can not be retried, the clients would be directly
> > affected by the errors.
> >
> > This commit disables the request prior to RPMB switching while allowing
> > the pause interface to still request a retune before the pause for other
> > use cases.
> >
> > This was verified with the sdhci-of-arasan driver (ZynqMP) configured
> > for HS200 using two separate eMMC cards (DG4064 and 064GB2). In both
> > cases, the error was easy to reproduce triggering every few tenths of
> > reads.
> >
> > Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
> > Acked-by: Avri Altman <avri.altman@wdc.com>
>
> Is the difference between this mail and the previous one just Avri's Ack?
> No need to resend for every tag you receive.

oops, every project with its own little idiosyncrasies sometimes I get
confused (u-boot, optee, ssl, tf-a..) yes, sorry about it, no differences.
