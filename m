From: Clemens Eisserer <linuxhippy@gmail.com>
Subject: Re: Fstrim fails on raspberry pi / SD-card
Date: Wed, 15 Jan 2014 09:50:44 +0100
Message-ID: <CAFvQSYT8fDApmhxr2mSXS53dYVp9Aw7dc2=z77T_gCd+YBGqhA@mail.gmail.com>
References: <CAFvQSYSG-JBqpgs_YjS6JmP-u-tkEH-4QXcRVPr2TaRhorSBJA@mail.gmail.com>
	<CAPDyKFrMYQkSvsiUeyN9FUPg4WOs=Fu1frVFvA9MkoyZzD+r=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oa0-f45.google.com ([209.85.219.45]:62229 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010AbaAOIup (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Jan 2014 03:50:45 -0500
Received: by mail-oa0-f45.google.com with SMTP id j17so874660oag.18
        for <linux-mmc@vger.kernel.org>; Wed, 15 Jan 2014 00:50:45 -0800 (PST)
In-Reply-To: <CAPDyKFrMYQkSvsiUeyN9FUPg4WOs=Fu1frVFvA9MkoyZzD+r=A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi Ulf,

> Have the mmc host driver setup MMC_CAP_ERASE? That is needed,
> otherwise the block queue wont be supporting DISCARD operations.

Thanks a lot for your reply. Indeed it seems MMC_CAP_ERASE is not
supported by the raspberry pi driver.
Just to be curious: Is the erease command also supported on SD cards
or only on eMMC?

Thanks, Clemens
