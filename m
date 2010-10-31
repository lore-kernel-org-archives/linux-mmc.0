From: Daniel Drake <dsd@laptop.org>
Subject: Re: MMC runtime PM patches break libertas probe
Date: Sun, 31 Oct 2010 15:10:14 +0000
Message-ID: <AANLkTi=QT6_zyddRz=3f6GDx-RVoiROOumhegm8pFuHU@mail.gmail.com>
References: <AANLkTim+Ez8FonyZDu42u4NX-KKV0YS_J-Ya-zT-Gf9q@mail.gmail.com>
	<AANLkTinEes6Er6-WW_t8esjazrLWZ0Z7jvYJDSZL9PNG@mail.gmail.com>
	<AANLkTinJ2K2cz9PSdyNoNGUS8GWfLpqRBH2C3XjO5vjO@mail.gmail.com>
	<AANLkTi=VAU=9Q+Ga7yQyu3aL7gV0vbzymQ-2uJAg1jf8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:44707 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755116Ab0JaPKQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 31 Oct 2010 11:10:16 -0400
Received: by wwe15 with SMTP id 15so5189265wwe.1
        for <linux-mmc@vger.kernel.org>; Sun, 31 Oct 2010 08:10:14 -0700 (PDT)
In-Reply-To: <AANLkTi=VAU=9Q+Ga7yQyu3aL7gV0vbzymQ-2uJAg1jf8@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-mmc@vger.kernel.org

On 31 October 2010 15:08, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> Quick question - how did you manage the power to the sd8686 ? Was it
> possible to power it down after boot or was it always kept high ?

I didn't do anything except boot then try and load the module. Does
that answer the question?

Daniel
