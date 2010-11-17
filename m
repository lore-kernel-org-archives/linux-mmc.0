From: Sujit Reddy <sujitreddy243@gmail.com>
Subject: mmc: Huge delay is seen when SD card is removed while transferring
 large media file
Date: Wed, 17 Nov 2010 20:08:38 +0530
Message-ID: <AANLkTimO5w4cH3f6m7-YR6XcEZESuWVvX19pk+H-PDcF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:51284 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756884Ab0KQOij (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 17 Nov 2010 09:38:39 -0500
Received: by pxi15 with SMTP id 15so507339pxi.19
        for <linux-mmc@vger.kernel.org>; Wed, 17 Nov 2010 06:38:39 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi,

Scenario: After SD card is inserted and partitions are mounted, start
transferring a large media file (for ex: 200MB) to SD. Remove the card
in between.

Problem: There is a huge delay of ~20secs when the user get notified
about the card removal. This delay depends on the size of the file to
be transferred.

dmesg shows continuous I/O errors even after card removal notification
(card xxxx removed in MMC layer)

==============================
[ 3182.791614] mmcblk0: error -123 sending status comand
[ 3182.791619] mmcblk0: error -123 sending read/write command,
response 0x0, card status 0x0
[ 3182.803637] mmcblk0: error -123 requesting status
[ 3182.805658] end_request: I/O error, dev mmcblk0, sector 1527146
[ 3182.805665] end_request: I/O error, dev mmcblk0, sector 1527154
[ 3182.805670] end_request: I/O error, dev mmcblk0, sector 1527162
[ 3182.805675] end_request: I/O error, dev mmcblk0, sector 1527170
[ 3182.805680] end_request: I/O error, dev mmcblk0, sector 1527178
[ 3182.805684] end_request: I/O error, dev mmcblk0, sector 1527186
[ 3182.805689] end_request: I/O error, dev mmcblk0, sector 1527194
[ 3182.805694] end_request: I/O error, dev mmcblk0, sector 1527202
[ 3182.805699] end_request: I/O error, dev mmcblk0, sector 1527210
[ 3182.805704] end_request: I/O error, dev mmcblk0, sector 1527218
[ 3182.805708] end_request: I/O error, dev mmcblk0, sector 1527226
[ 3182.805713] end_request: I/O error, dev mmcblk0, sector 1527234
[ 3182.805717] end_request: I/O error, dev mmcblk0, sector 1527242
[ 3182.805722] end_request: I/O error, dev mmcblk0, sector 1527250
[ 3182.805727] end_request: I/O error, dev mmcblk0, sector 1527258
[ 3182.805731] end_request: I/O error, dev mmcblk0, sector 1527266
====================================

I have observed that del_gendisk() called in mmc_blk_remove() to stop
new requests getting into the queue contributes much to the delay.
While flushing the requests there are still requests coming to process
(which fail as there is no card hence these errors). Isn't there any
notifier mechanism for VFS to know when the card is removed and as
soon as this card is removed new requests are flushed immediately
without any delay.

BTW I am using 2.6.35 kernel version and formatted the SD card with
FAT (also tried with ext3 but not much of difference seen). Card
insertion and removal is interrupt based.

Thanks
Sujit
