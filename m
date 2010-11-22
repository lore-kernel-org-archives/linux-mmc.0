From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH v4 1/2] MMC: add support for the Marvell Dove SDHCI controller
Date: Mon, 22 Nov 2010 12:10:17 +0200
Message-ID: <AANLkTin66iEqCgUKUFXGLZg4pu-mv=zb-E+x04BrC-=h@mail.gmail.com>
References: <cover.1288293593.git.mike@compulab.co.il> <ea487c43c1aff1d07355e0e0699e739c8617b96f.1288293593.git.mike@compulab.co.il>
 <AANLkTimhzUe+qODZYCvvrH6Hi06gV1yHVpS1LRHhXu7o@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:41227 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752911Ab0KVKKi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Nov 2010 05:10:38 -0500
Received: by iwn34 with SMTP id 34so2698845iwn.19
        for <linux-mmc@vger.kernel.org>; Mon, 22 Nov 2010 02:10:38 -0800 (PST)
In-Reply-To: <AANLkTimhzUe+qODZYCvvrH6Hi06gV1yHVpS1LRHhXu7o@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: saeed bishara <saeed.bishara@gmail.com>
Cc: Mike Rapoport <mike@compulab.co.il>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Saeed Bishara <saeed@marvell.com>, linux-arm-kernel@lists.infradead.org

On Mon, Nov 22, 2010 at 9:42 AM, saeed bishara <saeed.bishara@gmail.com=
> wrote:
> On Thu, Oct 28, 2010 at 9:23 PM, Mike Rapoport <mike@compulab.co.il> =
wrote:
=2E..
>> + =A0 =A0 =A0 bool "SDHCI support on Marvell's Dove SoC"
=2E..
>> + =A0 =A0 =A0 =A0 If you have a controller with this interface, say =
Y or M here.

Just a nitpick:  I guess that the "or M" in "say Y or M" is a typo
