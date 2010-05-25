From: Ian Molton <ian@mnementh.co.uk>
Subject: Re: [PATCH 0/3] tmio: let platforms decide upon write-protection
	availability
Date: Tue, 25 May 2010 20:09:14 +0100
Message-ID: <AANLkTilWMqVAhK17jdAXLzqWjXbHrxlLuE1oKEquCJj0@mail.gmail.com>
References: <Pine.LNX.4.64.1005191815491.3099@axis700.grange>
	<20100521123827.a8d7a87a.akpm@linux-foundation.org> <20100522073332.GA17814@linux-sh.org>
	<20100522081018.GD17814@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20100522081018.GD17814@linux-sh.org>
Sender: linux-sh-owner@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, linux-mmc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Hey,

I know I'm probably not the worlds promptest or easiest maintainer to
work with, but I'd just like to say a quick thanks to everyone
involved with the tmio-mmc driver. You've all put in a lot of effort
to make it what it is today.

Its really nice to see it being used in such a huge array of devices -
something which was my goal since the very beginning when I helped
author the MFD core. Back then ASIC3 was the only similar device I
knew of, and tmio-mmc owes some thanks to the early ASIC3 work as well
as a couple of people in Toshiba who were willing to stick their necks
out enough to get me what little documentation (register specs and
little more) that they could.

Cheers guys!

-- 
Ian Molton
Linux, Automotive, and other hacking:
http://www.mnementh.co.uk/
