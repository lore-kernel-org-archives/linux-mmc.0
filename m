From: Chris Ball <cjb@laptop.org>
Subject: Re: [Bug 38922] Lenovo T420 (Sandy Bridge) Crashes on SD Card gpt partition writing and io errors on insert
Date: Fri, 15 Jul 2011 15:59:56 -0400
Message-ID: <m27h7js4ar.fsf@bob.laptop.org>
References: <bug-38922-26132@https.bugzilla.kernel.org/>
	<201107151906.p6FJ6Xpe026619@demeter1.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:56865 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754574Ab1GOUAF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 15 Jul 2011 16:00:05 -0400
In-Reply-To: <201107151906.p6FJ6Xpe026619@demeter1.kernel.org>
	(bugzilla-daemon@bugzilla.kernel.org's message of "Fri, 15 Jul 2011
	19:06:33 GMT")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Peter Vollmer <vollmerpeter@googlemail.com>, Andrei Warkentin <andreiw@motorola.com>

Hi, moving to e-mail,

On Fri, Jul 15 2011, bugzilla-daemon@bugzilla.kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=38922

Andrei, please could you take a look at this bug?

> --- Comment #6 from Peter Vollmer <vollmerpeter@googlemail.com>
> 2011-07-15 19:06:22 ---
> Hi Chris,
> first of all thanks for your help. 
>
> I'm finish with some of your tips:
>
> The tip of comment #4 doesen't work. I've got the error message that the config
> wasn't able to load. Also the cardreader doesn't work.
>
> The other thing I've done was the bisection thing. The result is this commit:
>
> a3c7778f8153b9e4eceea6738973280b9e63c618 is the first bad commit
> commit a3c7778f8153b9e4eceea6738973280b9e63c618
> Author: Andrei Warkentin <andreiw@motorola.com>
> Date:   Mon Apr 11 16:13:42 2011 -0500
>
>     mmc: sdhci: R1B command handling + MMC_CAP_ERASE.
>
>     ERASE command needs R1B response, so fix R1B-type command
>     handling for SDHCI controller. For non-DAT commands using a busy
>     response, the cmd->cmd_timeout_ms (in ms) field is used for timeout
>     calculations.
>
>     Based on patch by Chuanxiao Dong <chuanxiao.dong@intel.com>
>     Signed-off-by: Andrei Warkentin <andreiw@motorola.com>
>     Signed-off-by: Chris Ball <cjb@laptop.org>
>
> :040000 040000 900ad3058ed393172ff7e68a2240a5404c28bfbb
> bb4a8b4bd336b0a53b8f90ebc37d16929e5ccfd4 M    drivers
>
> I hope I can help to resolve this problem.

Thanks very much for the bisection, Peter.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
