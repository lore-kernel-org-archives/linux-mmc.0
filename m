From: Daniel Drake <dsd@laptop.org>
Subject: Re: SDIO single IRQ optimization breaks libertas
Date: Sun, 29 May 2011 15:27:45 +0100
Message-ID: <BANLkTi=Y3rq_xnq5m6wj97uHHi5+ZCpURQ@mail.gmail.com>
References: <BANLkTi=xWwWh2z2r3THvf5DzvhUCX_ZB7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:58181 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754170Ab1E2O1p (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 29 May 2011 10:27:45 -0400
Received: by pvg12 with SMTP id 12so1310379pvg.19
        for <linux-mmc@vger.kernel.org>; Sun, 29 May 2011 07:27:45 -0700 (PDT)
In-Reply-To: <BANLkTi=xWwWh2z2r3THvf5DzvhUCX_ZB7A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, stefan.xk.nilsson@stericsson.com
Cc: libertas-dev@lists.infradead.org

On 29 May 2011 15:26, Daniel Drake <dsd@laptop.org> wrote:
> Hi,
>
> The following commit in 2.6.39 causes instant death for libertas_sdio
> when it receives its first interrupt during initialization:
>
> commit 06e8935febe687e2a561707d4c7ca4245d261dbe

The crash happens on this line of code in if_sdio_interrupt:

cause = sdio_readb(card->func, IF_SDIO_H_INT_STATUS, &ret);

card is NULL here

Daniel
