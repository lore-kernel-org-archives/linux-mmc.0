From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [RFC] remove quirk for broken clock - redundant since
 ops->max_clock defined
Date: Tue, 28 Sep 2010 15:11:05 +0400
Message-ID: <20100928111105.GA20742@oksana.dev.rtsoft.ru>
References: <8C0FC31B-681F-4541-AD64-43578FC926F6@marvell.com>
 <23CB1625-7451-41BD-AD43-73C588A1593F@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:40336 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221Ab0I1LLP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Sep 2010 07:11:15 -0400
Received: by ewy23 with SMTP id 23so1714256ewy.19
        for <linux-mmc@vger.kernel.org>; Tue, 28 Sep 2010 04:11:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <23CB1625-7451-41BD-AD43-73C588A1593F@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Tue, Sep 28, 2010 at 12:39:47AM -0700, Philip Rakity wrote:
> 
> >From 2b436be109ad004e94a2b63f71f6bb8e00f9d3da Mon Sep 17 00:00:00 2001
> From: Philip Rakity <prakity@marvell.com>
> Date: Tue, 28 Sep 2010 00:34:17 -0700
> Subject: [RFC] remove quirk for broken clock - redundant since ops->max_clock defined
> 
> Are we okay moving in this direction?  Patch is NOT tested since RFC -- does compile.
> 
> If we are moving away from using both quirks and host->ops to define
> platform specific actions -- just use the host->ops operation to
> get max_clock.

Again, I can only cite Pierre Ossman:

  On Sun, Feb 08, 2009 at 10:04:40PM +0100, Pierre Ossman wrote:
  | As I told Ben, I prefer if we stick to the standard as much as
  | possible. So no external info unless the register is set to zero.

Your patch breaks that rule. Other than that, technically it
looks OK.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
