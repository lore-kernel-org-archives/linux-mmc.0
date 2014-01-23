From: Grant Grundler <grundler@chromium.org>
Subject: Re: [PATCH] mmc-utils: add eMMC 5.0 FFU support
Date: Thu, 23 Jan 2014 12:39:53 -0800
Message-ID: <CANEJEGtKd-9bLAfQxiR_A1BkZxfA_o43BDPO6Atu6hav+Z5E2A@mail.gmail.com>
References: <1390501260-8730-1-git-send-email-grundler@chromium.org>
	<86ob321qw0.fsf@void.printf.net>
	<CANEJEGvpr3TB4PyfSOViy1D6avZQuKL7Km0DhnA5BiXDkYPV1w@mail.gmail.com>
	<86fvoe1ose.fsf@void.printf.net>
	<CANEJEGsYEF7pyWDHf2014hmJhEjJCYEfe1k+xso26tPY9cocEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:62468 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751331AbaAWUjy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Jan 2014 15:39:54 -0500
Received: by mail-oa0-f46.google.com with SMTP id n16so2743670oag.5
        for <linux-mmc@vger.kernel.org>; Thu, 23 Jan 2014 12:39:53 -0800 (PST)
In-Reply-To: <CANEJEGsYEF7pyWDHf2014hmJhEjJCYEfe1k+xso26tPY9cocEg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Grant Grundler <grundler@chromium.org>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, Puthikorn Voravootivat <puthik@chromium.org>, Gwendal Grignou <gwendal@chromium.org>

On Thu, Jan 23, 2014 at 11:30 AM, Grant Grundler <grundler@chromium.org> wrote:
...
> Sorry - I fixed that yesterday but apparently didn't update the "git
> format-patch" output I used to send the patch out today. /o\

I figure out what happened. Sharing to remind others of this silly brain fart.

I forgot "git commit --amend" wants the modified files listed (or -a
option) to include any additional changes with the existing commit.
So when i regenerated the patch file, it obviously didn't include the
most recent compile fixes. *sigh*.

cheers,
grant
