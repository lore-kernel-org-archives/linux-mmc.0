From: Carlo Caione <carlo@endlessm.com>
Subject: RTSX random behavior (on 10ec:5286)
Date: Tue, 15 Aug 2017 10:00:01 +0200
Message-ID: <CAL9uMOF7-mzy6-68t-09TQuX9BCxVVu_MtepZ0O_4v-jC9BO8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vk0-f43.google.com ([209.85.213.43]:33798 "EHLO
        mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753268AbdHOIAC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Aug 2017 04:00:02 -0400
Received: by mail-vk0-f43.google.com with SMTP id n125so667969vke.1
        for <linux-mmc@vger.kernel.org>; Tue, 15 Aug 2017 01:00:02 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: micky_ching@realsil.com.cn, wei_wang@realsil.com.cn, Linux Upstreaming Team <linux@endlessm.com>

Hi,
here at Endless we are enabling a laptop (ASUS Z550MA) that is showing
a really random behavior with the RTSX driver. The hardware is
10ec:5286.

Every time we reboot this laptop with no SD card inserted in the slot
we hit (randomly) one of the following cases:

1) The probe of rtsx_pci fails with a timeout (rtsx_pci_send_cmd 323).
See [1]. SD card reader doesn't work at all in this case.

2) When issuing the MS_TPC_SET_RW_REG_ADRS command the transaction
fails (MS_TRANS_CFG: 0x10). See [2]

3) A phantom (not present) DUO card is detected in the slot. See [3].

4) A phantom (not present) card with (type, category, class) == (0x04,
0x04, 0x04) is detected in the slot. The log is basically the same as
[3] but with a different type of card detected.

Any idea what's going on or any hint to better debugging this situation?

Thank you,

[1] https://paste.fedoraproject.org/paste/ukLr~Z4fcrVw-g4sMSiBNg
[2] https://paste.fedoraproject.org/paste/MZN9QbBwNd8okKyBIr7NiA
[3] https://paste.fedoraproject.org/paste/E45yNAkgTPDblb9sApTvnQ

--
Carlo Caione
