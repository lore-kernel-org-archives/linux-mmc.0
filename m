From: Dan Carpenter <error27@gmail.com>
Subject: [smatch stuff] mmv/VUB300: null dereferences in error handling
Date: Thu, 26 May 2011 20:14:55 +0300
Message-ID: <20110526171455.GJ14591@shale.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:56187 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752693Ab1EZRPW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 26 May 2011 13:15:22 -0400
Received: by bwz15 with SMTP id 15so597059bwz.19
        for <linux-mmc@vger.kernel.org>; Thu, 26 May 2011 10:15:20 -0700 (PDT)
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: tony.olech@elandigitalsystems.com
Cc: linux-mmc@vger.kernel.org


In vub300_probe() from drivers/mmc/host/vub300.c we dereference
vub300 when it's a NULL variable.  Btw, let's remove the bogus
initialization to NULL so that gcc will complain if the bug gets
introduced again.

  2119          if (!command_out_urb) {
  2120                  retval = -ENOMEM;
  2121                  dev_err(&vub300->udev->dev,
                                 ^^^^^^^^^^^^
  2122                          "not enough memory for the command_out_urb\n");
  2123                  goto error0;
  2124          }
  2125          command_res_urb = usb_alloc_urb(0, GFP_KERNEL);
  2126          if (!command_res_urb) {
  2127                  retval = -ENOMEM;
  2128                  dev_err(&vub300->udev->dev,
                                 ^^^^^^^^^^^^
  2129                          "not enough memory for the command_res_urb\n");
  2130                  goto error1;
  2131          }
  2132          /* this also allocates memory for our VUB300 mmc host device */
  2133          mmc = mmc_alloc_host(sizeof(struct vub300_mmc_host), &udev->dev);
  2134          if (!mmc) {
  2135                  retval = -ENOMEM;
  2136                  dev_err(&vub300->udev->dev,
                                 ^^^^^^^^^^^^
  2137                          "not enough memory for the mmc_host\n");
  2138                  goto error4;
  2139          }

regards,
dan carpenter
