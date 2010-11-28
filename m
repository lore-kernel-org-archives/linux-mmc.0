From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 2/3] mmc: sdio: don't reinitialize nonremovable
 powered-resumed cards
Date: Sun, 28 Nov 2010 10:58:58 +0200
Message-ID: <AANLkTikHxEzcpkesakVAshPW8XeRDu8H7PP0heu-dFra@mail.gmail.com>
References: <1290921690-6133-1-git-send-email-ohad@wizery.com>
 <1290921690-6133-3-git-send-email-ohad@wizery.com> <AANLkTiko9brvK33=GjzJgzGdmoufyNn=_mCNfUFAP-dT@mail.gmail.com>
 <AANLkTimq7pFOniQECotBL_zSA+RGHGfT3q2JHi+Q61qx@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:44410 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751760Ab0K1I7T (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 28 Nov 2010 03:59:19 -0500
Received: by iwn5 with SMTP id 5so649060iwn.19
        for <linux-mmc@vger.kernel.org>; Sun, 28 Nov 2010 00:59:18 -0800 (PST)
In-Reply-To: <AANLkTimq7pFOniQECotBL_zSA+RGHGfT3q2JHi+Q61qx@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirqus@gmail.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

2010/11/28 Ohad Ben-Cohen <ohad@wizery.com>:
>>> I have not switched all existing code to mmc_card_is_powered_resumed(),
>>> I can do that as a subsequent clean up patch.

(i just prefer not to mix functional changes with cleanups in a single patch)


>
