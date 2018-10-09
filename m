From: James Nuss <jamesnuss@nanometrics.ca>
Subject: [PATCH 0/7] fix bugs in write_reliability and enh_area set commands + more extcsd parsing
Date: Tue,  9 Oct 2018 13:31:04 -0400
Message-ID: <cover.1539103468.git.jamesnuss@nanometrics.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

[PATCH 1-3] just introduce further parsing and human-readable output of eMMC 5.0+ fields in the extcsd:
  mmc-utils: interpret OPTIMAL_*_SIZE fields in extcsd
  mmc-utils: treat FIRMWARE_VERSION as binary field instead of string
  mmc-utils: interpret DEVICE_VERSION when printing extcsd

[PATCH 4-5] are critical bug fixes for the current version. This addresses concerns previously raised in threads wrt write-reliability setting:
https://www.spinics.net/lists/linux-mmc/msg41952.html
https://www.spinics.net/lists/linux-mmc/msg43171.html

[PATCH 6] is a critical bug fix for the current version to allow setting of enhanced and extended attributes on multiple partitions.

[PATCH 7] is a version up-rev:
  mmc-utils: update version number to 0.2

James Nuss (7):
  mmc-utils: interpret OPTIMAL_*_SIZE fields in extcsd
  mmc-utils: treat FIRMWARE_VERSION as binary field instead of string
  mmc-utils: interpret DEVICE_VERSION when printing extcsd
  mmc-utils: Introduce write_reliability set_register command
  mmc-utils: remove write_reliability set command
  mmc-utils: discrete commands for enhanced and extended attribute
  mmc-utils: update version number to 0.2

 mmc.c      |  52 ++++++++++---
 mmc.h      |  14 +++-
 mmc_cmds.c | 243 ++++++++++++++++++++++++++++++++++++++++++++-----------------
 mmc_cmds.h |   6 +-
 4 files changed, 235 insertions(+), 80 deletions(-)

-- 
2.7.4


-- 
This message is intended exclusively for the individual or entity to which 
it is addressed. This communication may contain information that is 
proprietary, privileged, confidential or otherwise legally exempt from 
disclosure. If you are not the named addressee, or have been inadvertently 
and erroneously referenced in the address line, you are not authorized to 
read, print, retain, copy or disseminate this message or any part of it. If 
you have received this message in error, please notify the sender 
immediately by e-mail and delete all copies of the message.
