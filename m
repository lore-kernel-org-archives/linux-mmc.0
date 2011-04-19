From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] mmc: USB SDIO/SD/MMC Host Controller (VUB300) driver Re-Resubmission
Date: Tue, 19 Apr 2011 15:21:52 +0200
Message-ID: <201104191521.53127.arnd@arndb.de>
References: <20B0EAA71DD7413A9A29D0493C6C1D87@AN00536> <201104191410.42177.arnd@arndb.de> <1303216358.1622.27.camel@apple-mac>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:57745 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754231Ab1DSNWA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Apr 2011 09:22:00 -0400
In-Reply-To: <1303216358.1622.27.camel@apple-mac>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Olech <tony.olech@elandigitalsystems.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

On Tuesday 19 April 2011, Tony Olech wrote:
> What is wrong in wanting to support non-technical users?
> Especially since there are no backward compatible issues
> involved at all.

It's good to support non-technical users. Things that are
bad about your patch are:

* Have interfaces that work only for your customers. If a
  specific interface is a good thing to have, it certainly
  is good to have it for everyone.

* Fragmentation between drivers. In addition, if someone
  else needs a similar interface and introduces it in another
  driver, we can end up with incompatible ways of getting
  the same information, which is an absolute support nightmare
  for people that want to support all users.

* Not following the interface standards. You don't get to
  make the decision which interfaces are helpful and which
  ones are not, they have to be agreed upon. The files you were
  suggesting violate the rules about how they should look
  like, in particular having one value per file. Doing something
  else is very confusing to users that have reasonable expectations
  about the contents.

So even though you had the intentions to make support easier
for some people, you end up with a situation that makes it harder
to support for everyone.

	Arnd
