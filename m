From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: MMC updates for 3.2-rc1
Date: Fri, 28 Oct 2011 14:20:17 -0700
Message-ID: <CA+55aFwwEVCVTdFKSb3Rszb-s90fV3ocOWrbevrhYJV8X6bWog@mail.gmail.com>
References: <m2fwide1ai.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:55489 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933393Ab1J1VUj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Oct 2011 17:20:39 -0400
In-Reply-To: <m2fwide1ai.fsf@bob.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org

On Fri, Oct 28, 2011 at 5:41 AM, Chris Ball <cjb@laptop.org> wrote:
>
> Does the below method of verifying a signed pull request work well for you?

This kind of GPG-signed thing works well (with explicit BEGIN PGP
SIGNED MESSAGE quoting).

Not that you even need it, since it's on git.kernel.org, so it's
doubly verified.

Pulled,

                       Linus
