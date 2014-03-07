From: Grant Grundler <grundler@google.com>
Subject: RFC: raw extcsd dump
Date: Fri, 7 Mar 2014 08:31:21 -0800
Message-ID: <CANEJEGtyGM0jbyy9b0SSY-9D90J8EZFNWYVOUMLQ27rz1Jkztg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oa0-f47.google.com ([209.85.219.47]:33857 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751645AbaCGQbW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 7 Mar 2014 11:31:22 -0500
Received: by mail-oa0-f47.google.com with SMTP id i11so4367829oag.6
        for <linux-mmc@vger.kernel.org>; Fri, 07 Mar 2014 08:31:21 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Chris,
Are you interested in "raw dump" of extcsd data?

We need it to dump vendor specific data that happens to be in a reserved field.

Chromium.org code review is here:
   https://chromium-review.googlesource.com/#/c/189002/

git magic to pull that patch is here:
   git pull https://chromium.googlesource.com/chromiumos/third_party/mmc-utils
refs/changes/02/189002/4

I can also post the patch as normal inline if you are interested.

cheers
grant
