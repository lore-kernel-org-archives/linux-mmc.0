From: Daniel Drake <dsd@laptop.org>
Subject: Re: -ENOSYS suspend-powerdown regression
Date: Sun, 5 Jun 2011 13:31:57 +0100
Message-ID: <BANLkTimKYKX=k2U1_WyhaWZ1wRpWUF6pMQ@mail.gmail.com>
References: <BANLkTimdp2n1qhLQmTk+k_M5_WowhJqPyQ@mail.gmail.com>
	<BANLkTimRWqo1M7OOQmdWOxSQvqiNx48Ftg@mail.gmail.com>
	<BANLkTikvP3hc+CHEwrUEDqN6McwswikS-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:36447 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756017Ab1FEMb6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 5 Jun 2011 08:31:58 -0400
Received: by pzk9 with SMTP id 9so1456326pzk.19
        for <linux-mmc@vger.kernel.org>; Sun, 05 Jun 2011 05:31:57 -0700 (PDT)
In-Reply-To: <BANLkTikvP3hc+CHEwrUEDqN6McwswikS-Q@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-mmc@vger.kernel.org

On 5 June 2011 00:08, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> We can stop checking the return value of pm_runtime_get_sync in
> sdio_bus_remove, like pci_device_remove is doing, but I don't think
> that's enough: I guess libertas' if_sdio_remove won't be so happy
> dealing with a powered off card.
>
> Can you try the following please (untested):

Thanks, that seems to be working.
