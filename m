From: Daniel Drake <dsd@laptop.org>
Subject: Re: MMC runtime PM patches break libertas probe
Date: Sun, 31 Oct 2010 14:55:14 +0000
Message-ID: <AANLkTinJ2K2cz9PSdyNoNGUS8GWfLpqRBH2C3XjO5vjO@mail.gmail.com>
References: <AANLkTim+Ez8FonyZDu42u4NX-KKV0YS_J-Ya-zT-Gf9q@mail.gmail.com>
	<AANLkTinEes6Er6-WW_t8esjazrLWZ0Z7jvYJDSZL9PNG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:61779 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755937Ab0JaOzP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 31 Oct 2010 10:55:15 -0400
Received: by wwe15 with SMTP id 15so5180541wwe.1
        for <linux-mmc@vger.kernel.org>; Sun, 31 Oct 2010 07:55:14 -0700 (PDT)
In-Reply-To: <AANLkTinEes6Er6-WW_t8esjazrLWZ0Z7jvYJDSZL9PNG@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-mmc@vger.kernel.org

On 31 October 2010 14:42, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> I guess the error comes from mmc_sdio_init_card() - can you please
> check out what exactly triggers it inside that function (just put some
> printk's there..) ?

	/*
	 * For native busses:  set card RCA and quit open drain mode.
	 */
	if (!powered_resume && !mmc_host_is_spi(host)) {
		err = mmc_send_relative_addr(host, &card->rca);

This returns -110

Thanks,
Daniel
