From: Ben Gardiner <bengardiner@nanometrics.ca>
Subject: [PATCH 1/8] allow environment and command-line supplied make vars
Date: Thu, 30 May 2013 17:12:44 -0400
Message-ID: <71c838fde94a73a030a600d7b73928c6a919c51a.1369947867.git.bengardiner@nanometrics.ca>
References: <cover.1369947867.git.bengardiner@nanometrics.ca>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:62327 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758235Ab3E3VNJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 30 May 2013 17:13:09 -0400
Received: by mail-ie0-f171.google.com with SMTP id s9so1927414iec.16
        for <linux-mmc@vger.kernel.org>; Thu, 30 May 2013 14:13:08 -0700 (PDT)
In-Reply-To: <cover.1369947867.git.bengardiner@nanometrics.ca>
In-Reply-To: <cover.1369947867.git.bengardiner@nanometrics.ca>
References: <cover.1369947867.git.bengardiner@nanometrics.ca>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org

Most useful when cross-compiling.

Signed-off-by: Ben Gardiner <bengardiner@nanometrics.ca>
---
 Makefile |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index f03f131..ae846e2 100644
--- a/Makefile
+++ b/Makefile
@@ -1,12 +1,14 @@
-CC = gcc
+CC ?= gcc
 AM_CFLAGS = -D_FILE_OFFSET_BITS=64 -D_FORTIFY_SOURCE=2
-CFLAGS = -g -O2
+CFLAGS ?= -g -O2
 objects = mmc.o mmc_cmds.o
 
-CHECKFLAGS= -Wall -Werror -Wuninitialized -Wundef
+CHECKFLAGS = -Wall -Werror -Wuninitialized -Wundef
 
 DEPFLAGS = -Wp,-MMD,$(@D)/.$(@F).d,-MT,$@
 
+override CFLAGS := $(CHECKFLAGS) $(AM_CFLAGS) $(CFLAGS)
+
 INSTALL = install
 prefix ?= /usr/local
 bindir = $(prefix)/bin
@@ -26,7 +28,7 @@ all: $(progs) manpages
 ifdef C
 	$(check) $<
 endif
-	$(CC) $(CHECKFLAGS) $(AM_CFLAGS) $(DEPFLAGS) $(CFLAGS) -c $<
+	$(CC) $(CPPFLAGS) $(CFLAGS) $(DEPFLAGS) -c $<
 
 mmc: $(objects)
 	$(CC) $(CFLAGS) -o $@ $(objects) $(LDFLAGS) $(LIBS)
-- 
1.7.3.5

