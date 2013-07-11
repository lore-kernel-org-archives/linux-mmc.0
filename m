From: "David Laight" <David.Laight@ACULAB.COM>
Subject: RE: [PATCH 1/4 V2] powerpc/85xx: Add support for 85xx cpu type detection
Date: Thu, 11 Jul 2013 09:43:35 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B72DE@saturn3.aculab.com>
References: <1373441941-32650-1-git-send-email-Haijun.Zhang@freescale.com> (from Haijun.Zhang@freescale.com on Wed Jul 10 02:39:01 2013) <1373492893.8183.236@snotra>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx0.aculab.com ([213.249.233.131]:36299 "HELO mx0.aculab.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755602Ab3GKIpJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 11 Jul 2013 04:45:09 -0400
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 26461-10 for <linux-mmc@vger.kernel.org>;
 Thu, 11 Jul 2013 09:45:05 +0100 (BST)
Content-class: urn:content-classes:message
In-Reply-To: <1373492893.8183.236@snotra>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Scott Wood <scottwood@freescale.com>
Cc: Zhao Chenhui <chenhui.zhao@freescale.com>, linux-mmc@vger.kernel.org, r39252@freescale.com, AFLEMING@freescale.com, Haijun Zhang <Haijun.Zhang@freescale.com>, cbouatmailru@gmail.com, cjb@laptop.org, linuxppc-dev@lists.ozlabs.org, X.Xie@freescale.com

> > +#define IS_SVR_REV(svr, maj, min) \
> > +	((SVR_MAJ(svr) == (maj)) && (SVR_MIN(svr) == (min)))
> 
> I don't think IS_SVR_REV is needed.  Callers can just do "if
> (SVR_REV(svr) == 0x30)" or whatever, especially since we're relying on
> them to do this for greater/less than comparisons.

Not only that, I'd guess that 'maj' and 'min' are likely to be
constants - so you'd want to combine them and compare against 'svr'
rather than have two conditionals.

	David



