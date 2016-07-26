From: Mauro Santos <registo.mailling@gmail.com>
Subject: Re: rtsx_pci mmc erase support
Date: Tue, 26 Jul 2016 09:16:06 +0100
Message-ID: <87862ef5-5a39-179a-3aec-62f9111bc2b0@gmail.com>
References: <5a550d59-720c-a6db-27fb-40b08e263fad@gmail.com>
 <CAPDyKFoCF-H86irhovpqM9Z-RW3CGvOvY0jdWLME_wvvYxj7+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:38338 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917AbcGZIQN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Jul 2016 04:16:13 -0400
Received: by mail-wm0-f51.google.com with SMTP id o80so4358903wme.1
        for <linux-mmc@vger.kernel.org>; Tue, 26 Jul 2016 01:16:12 -0700 (PDT)
In-Reply-To: <CAPDyKFoCF-H86irhovpqM9Z-RW3CGvOvY0jdWLME_wvvYxj7+g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 25-07-2016 22:54, Ulf Hansson wrote:
> These commands don't require a specific HW feature. but only software
> support in the driver - which indeed is missing.
> 
> Although, one should know, the discard/erase feature in the mmc core
> has since long been poorly implemented.
> There are a few patches that greatly improves the behaviour and which
> are queued for 4.8.
> 
> Would you be interested to test the above changes + plus some
> additional which I can provide you to enable erase/discard for
> rtsx_pci?

I don't mind testing it, point me in the right direction and let me know
which tests you want me to do.

Regards,
Mauro Santos
