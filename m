From: viresh kumar <viresh.kumar@st.com>
Subject: mmc_test mmc0:0001: Can't create file. Perhaps debugfs is disabled
Date: Wed, 22 Dec 2010 17:29:47 +0530
Message-ID: <4D11E833.7000506@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog110.obsmtp.com ([207.126.144.129]:39551 "EHLO
	eu1sys200aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752234Ab0LVL76 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Dec 2010 06:59:58 -0500
Received: from zeta.dmz-ap.st.com (ns6.st.com [138.198.234.13])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 020BFE5
	for <linux-mmc@vger.kernel.org>; Wed, 22 Dec 2010 11:59:52 +0000 (GMT)
Received: from Webmail-ap.st.com (eapex1hubcas3.st.com [10.80.176.67])
	by zeta.dmz-ap.st.com (STMicroelectronics) with ESMTP id A649B149E
	for <linux-mmc@vger.kernel.org>; Wed, 22 Dec 2010 11:59:52 +0000 (GMT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Shiraz HASHIM <shiraz.hashim@st.com>

Hello,

I am using mmc_test.c driver present in drivers/mmc/test.c

Whenever i insert my card after booting linux i get this error:
"mmc_test mmc0:0001: Can't create file. Perhaps debugfs is disabled"

I debugged a bit and found something strange. In file drivers/mmc/core/bus.c
following code is present.

int mmc_add_card(struct mmc_card *card)
{
...

	ret = device_add(&card->dev);
	if (ret)
		return ret;

#ifdef CONFIG_DEBUG_FS
	mmc_add_card_debugfs(card);
#endif

...
}

After device_add is called mmc_test_register_file_test routine (present in mmc_test.c) is
called and it tries to add "test" file inside card->debugfs_root directory.

But this directory is not actually present till the time mmc_add_card_debugfs() is called,
which actually creates it.

reversing the sequence of above routines seems to solve this issue.
I am not sure if i am doing something wrong or it is actually a bug.

-- 
viresh
ST Microelectronics
India.
