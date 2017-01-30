From: Gabriel Krisman Bertazi <krisman@collabora.co.uk>
Subject: Re: [PATCH v2 RESEND] sdhci: Ignore unexpected CARD_INT interrupts
Date: Mon, 30 Jan 2017 11:40:36 -0200
Message-ID: <874m0gll7v.fsf@dilma.collabora.co.uk>
References: <20170116142342.21283-1-krisman@collabora.co.uk>
        <CAPDyKFpowPmbwvHL9NL60zAABfW53sDKkp0Ag5aXs4jZZLC=Dg@mail.gmail.com>
        <87wpdg9uob.fsf@dilma.collabora.co.uk>
        <CAPDyKFq2aUkk4qzcLNoityHbOYTHCq_OiO9HVLuWjcGSJX0aWw@mail.gmail.com>
        <87poj4loa5.fsf@dilma.collabora.co.uk>
        <2b37a0fa-46e3-ec4e-3f9c-9e1bb7dcda1e@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38652 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753374AbdA3Nk4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Jan 2017 08:40:56 -0500
In-Reply-To: <2b37a0fa-46e3-ec4e-3f9c-9e1bb7dcda1e@intel.com> (Adrian Hunter's
        message of "Mon, 30 Jan 2017 14:40:30 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Gustavo Padovan <gustavo.padovan@collabora.com>, Sjoerd Simons <sjoerd.simons@collabora.co.uk>

Adrian Hunter <adrian.hunter@intel.com> writes:
> Did you test normal SDIO operation was unaffected?  Please do that before
> sending it to stable.

I don't have any SDIO card in hand to confirm it right now.  would you
or Ulf be able to give it a try?  I'll keep looking for one.

-- 
Gabriel Krisman Bertazi
