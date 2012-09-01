From: "George Spelvin" <linux@horizon.com>
Subject: SD 3.00 Physical layer FULL specification
Date: 31 Aug 2012 22:27:55 -0400
Message-ID: <20120901022755.10343.qmail@science.horizon.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from science.horizon.com ([71.41.210.146]:64778 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752319Ab2IACef (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 31 Aug 2012 22:34:35 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: arnd.bergmann@linaro.org, linux@horizon.com

I was just trolling around the net trying to figure out what the
Pm parameter and speed class of SD cards meant, and I came across a
definitive answer in the form of a copy of Part 1 of the unredacted
v3.00 specification (April 16, 2009) at

http://www.61ic.com/code/attachment.php?aid=73871&k=cfaccbbb80c338769bd7282636c0ca7e&t=1331742726

I have of course snarfed a copy, and if anyone else on the list
would benefit from one, I figured it was worth sharing.

In particular, it documents the FAT update optimizations in SD cards
(section 4.3.1.7, p. 112).

If anyone cares, write performance is defined in terms of updates to
"allocation units" (i.e. erase blocks) 512K-4MiB in size of a card-defined
size, which are made up of "recording units" (i.e. FAT clusters).
Table 4-51 on p. 113 gives the limits.

An update to an allocation unit is a combination of writes of new data
and and moves (copies) of old data from the pre-existing AU.  Each of
these has a performance standard, Pw and Pm, respectively.

For a "Class n" card, Pw and Pr must be >= n MB/s, while Pm must be
>= n/2 MB/s.  (Exacpt, oddly, class 10 has NO lower bound on Pm.)
