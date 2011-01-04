From: David Vrabel <david.vrabel@csr.com>
Subject: Re: [PATCH 3/4] mmc: add MMC_QUIRK_DISABLE_CD
Date: Tue, 04 Jan 2011 23:04:52 +0000
Message-ID: <4D23A794.8020106@csr.com>
References: <1294175416-12358-1-git-send-email-ohad@wizery.com> <1294175416-12358-3-git-send-email-ohad@wizery.com> <4D239AAF.6090202@csr.com> <AANLkTikKDkE8eoRct_DN++dRTZ8uEMqUKN2GZdCngRKQ@mail.gmail.com> <AANLkTinEWsYBqgchwbjT2ZnoVYPcibJDF2Jt3v1AysUt@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smarthost01.mail.zen.net.uk ([212.23.3.140]:42598 "EHLO
	smarthost01.mail.zen.net.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750940Ab1ADXFJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Jan 2011 18:05:09 -0500
In-Reply-To: <AANLkTinEWsYBqgchwbjT2ZnoVYPcibJDF2Jt3v1AysUt@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

On 04/01/2011 22:27, Ohad Ben-Cohen wrote:
> On Wed, Jan 5, 2011 at 12:13 AM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
>>> Whether this pull up should be
>>> enabled or disabled is determined by the board (not the card).  The
>>> pull-up should be disabled if the board has a pull-up external to the
>>> card, otherwise it must remain enabled.
>>
>> Agree.
> 
> It might make more sense to use a host CAP though for this (i.e.
> MMC_CAP_DISABLE_CD).

Could we unconditionally disable the card's internal pull-up?  A board
that's using DAT3 for card detection should have a switchable pull-down
/and/ a switchable pull-up.

This would cause regressions on boards that aren't properly designed and
have omitted the pull-up.  Are there boards like this?

David
