From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/2] mmc: core: pre-patch for next eMMC version
Date: Wed, 29 Aug 2012 13:53:43 +0200
Message-ID: <CAPDyKFo0mwkbiQEc8cmPRu9AbB8mUQhuq4AWq=e03fUD1dfKHg@mail.gmail.com>
References: <5036C96A.7070300@samsung.com>
	<CAPDyKFqJynoS5d3EmnRi4CxmUyOMYBRzy2spDgUTfT=7+0Xg6Q@mail.gmail.com>
	<503C4A01.2030200@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:59744 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753032Ab2H2Lxo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 29 Aug 2012 07:53:44 -0400
Received: by wgbdr13 with SMTP id dr13so469038wgb.1
        for <linux-mmc@vger.kernel.org>; Wed, 29 Aug 2012 04:53:43 -0700 (PDT)
In-Reply-To: <503C4A01.2030200@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>

Hi Jaehoon,

On 28 August 2012 06:33, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Hi Ulf,
>
> This patch is to support eMMC5.0.(already discussing on eMMC5.0.)
> Revision value is defined the 0x7 into ext_csd register.(in eMMC5.0's case)

Until the spec is really set we should not add some new code for this,
it does not make sense to kind of guess.

>
> And case of Quirks is preparation patch to prevent the problem that should exist.
> That Quirks can also use for backward compatibility.
> (if card is greater version than eMMC4.5 and need to use only eMMC4.5 feature?
>  then can use quirks and known_rev.)

It is just speculations about potential problems with eMMC 5.0. I
think we can leave this to later, if/when we see a need for it.

Kind regards
Ulf Hansson
