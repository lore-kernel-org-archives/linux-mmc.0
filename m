From: Roman Pen <r.peniaev@gmail.com>
Subject: [PATCH 0/2] mmc-utils: RPMB support
Date: Mon, 21 Jul 2014 21:53:43 +0900
Message-ID: <1405947225-6347-1-git-send-email-r.peniaev@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:51039 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932129AbaGUMx5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Jul 2014 08:53:57 -0400
Received: by mail-pd0-f169.google.com with SMTP id y10so9156926pdj.28
        for <linux-mmc@vger.kernel.org>; Mon, 21 Jul 2014 05:53:57 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
Cc: Ben Gardiner <bengardiner@nanometrics.ca>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Roman Pen <r.peniaev@gmail.com>

This is simple RPMB support for 4 operations:
  write-key
  read-counter
  write-block
  read-block

I did not attempt to implement multiple blocks read/write,
thus only 1 block (256 b) is supported right now.

Also I had to take HMAC SHA256 implementation as 3rdparty to
sign RPMB messages.

Roman Pen (2):
  mmc-utils: RPMB: add HMAC SHA256 support
  mmc-utils: RPMB: add support for 4 rpmb operations

 3rdparty/hmac_sha/hmac_sha2.c | 544 ++++++++++++++++++++++++
 3rdparty/hmac_sha/hmac_sha2.h | 140 +++++++
 3rdparty/hmac_sha/sha2.c      | 949 ++++++++++++++++++++++++++++++++++++++++++
 3rdparty/hmac_sha/sha2.h      | 108 +++++
 Makefile                      |   8 +-
 mmc.c                         |  28 ++
 mmc.h                         |   6 +
 mmc_cmds.c                    | 419 +++++++++++++++++++
 mmc_cmds.h                    |   4 +
 9 files changed, 2204 insertions(+), 2 deletions(-)
 create mode 100644 3rdparty/hmac_sha/hmac_sha2.c
 create mode 100644 3rdparty/hmac_sha/hmac_sha2.h
 create mode 100644 3rdparty/hmac_sha/sha2.c
 create mode 100644 3rdparty/hmac_sha/sha2.h

-- 
2.0.0

