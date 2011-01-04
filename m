From: David Vrabel <david.vrabel@csr.com>
Subject: Re: [PATCH 3/4] mmc: add MMC_QUIRK_DISABLE_CD
Date: Tue, 04 Jan 2011 22:09:51 +0000
Message-ID: <4D239AAF.6090202@csr.com>
References: <1294175416-12358-1-git-send-email-ohad@wizery.com> <1294175416-12358-3-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smarthost03.mail.zen.net.uk ([212.23.3.142]:51059 "EHLO
	smarthost03.mail.zen.net.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750801Ab1ADWKM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Jan 2011 17:10:12 -0500
In-Reply-To: <1294175416-12358-3-git-send-email-ohad@wizery.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

On 04/01/2011 21:10, Ohad Ben-Cohen wrote:
> 006ebd5d introduced sdio_disable_cd(), which disconnects the pull-up
> resistor on CD/DAT[3] (pin 1) of the card.
> 
> Make it possible to start using sdio_disable_cd() by introducing
> MMC_QUIRK_DISABLE_CD.

How are you intending to use this?  Whether this pull up should be
enabled or disabled is determined by the board (not the card).  The
pull-up should be disabled if the board has a pull-up external to the
card, otherwise it must remain enabled.

David
