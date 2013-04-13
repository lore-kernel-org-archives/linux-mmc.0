From: "Steven J. Magnani" <steve@digidescorp.com>
Subject: Re: [PATCH] mmc: debugfs: Add debugfs ability to read CID and CSD
Date: Fri, 12 Apr 2013 20:54:03 -0500
Message-ID: <1365818043.1691.23.camel@iscandar.digidescorp.com>
References: <1365796013-11399-1-git-send-email-smagnani@iscandar.digidescorp.com>
	 <CA+20K0DFA9r+fLhhbFnzx+t2wQ6+UH3DAWhoiF2W1g=ok8hyBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.digidescorp.com ([50.73.98.161]:4931 "EHLO
	mail.digidescorp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751998Ab3DMCBl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 12 Apr 2013 22:01:41 -0400
In-Reply-To: <CA+20K0DFA9r+fLhhbFnzx+t2wQ6+UH3DAWhoiF2W1g=ok8hyBQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Johan Rudholm <jrudholm@gmail.com>
Cc: Steve Magnani <smagnani@iscandar.digidescorp.com>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-kernel@vger.kernel.org


On Sat, 2013-04-13 at 01:06 +0200, Johan Rudholm wrote: 
> I believe these registers are already available as sysfs nodes? I
> don't have access to the proper hardware right now, but I'm pretty
> sure you'll find something if you do for instance "find /sys -name
> csd".

Ahh. Thanks for the tip; I hadn't thought to look there since I found
the ext_csd under debugfs.
------------------------------------------------------------------------
Steven J. Magnani               "I claim this network for MARS!
www.digidescorp.com              Earthling, return my space modulator!"

#include <standard.disclaimer> 


