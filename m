From: Tomas Melin <tomas.melin@vaisala.com>
Subject: Re: Possible bug in mmc-utils: Is MMC 'partition setting completed'
 required for 'write reliability'?
Date: Wed, 22 Mar 2017 11:13:14 +0200
Message-ID: <00b923df-6aad-6428-3247-ead8995066c1@vaisala.com>
References: <70BB63196E12E948A726997ECFE8646BC0CD58D9@Elexis-Exch02.elexisad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hel-mailgw-01.vaisala.com ([193.143.230.17]:51513 "EHLO
        hel-mailgw-01.vaisala.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751370AbdCVJNS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Mar 2017 05:13:18 -0400
In-Reply-To: <70BB63196E12E948A726997ECFE8646BC0CD58D9@Elexis-Exch02.elexisad.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Brinkmann, Harald" <Harald.Brinkmann@bst-international.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "chris@printf.net" <chris@printf.net>

Hi,

On 03/20/2017 05:40 PM, Brinkmann, Harald wrote:
> 
> I am having problems with the 'mmc' userspace command in mmc-utils.
> This call:
> 
>> /usr/bin/mmc write_reliability set -y 0 /dev/mmcblk1
> 
> results in:
> 
>> setting OTP PARTITION_SETTING_COMPLETED!
>> Setting OTP PARTITION_SETTING_COMPLETED failed on /dev/mmcblk1
> 
> Which is not too surprising, since I only want to set the write
> reliability bit and did not touch any (mmc-)partition information, so
> that it probably still is invalid.

My experience is that you need to first do the partitioning before the write
reliability flag can be set. This is because the partition for which the write
reliability gets set, first needs to be configured for enhanced mode (enh_area set).

Regards
Tomas


> 
> If I then type:
> 
>> /usr/bin/mmc extcsd read /dev/mmcblk1
> 
> that reliable write bit is shown as set:
> 
>> Write reliability setting register [WR_REL_SET]: 0x01

The bit gets set, but is it still on after a reboot?
> 
> After consulting the JEDEC standards I failed to find the necessity to
> set the "Partition setting complete" bit to actually enable the
> "reliable write" function. If there *is* no connection, then commit
> 196d0d29588867bed50cd28b8f03cbbb5e0e6608 (2013-09-19 17:14:29) must not
> try to set that bit and also must refrain from setting the reliable
> write bit itself when in dry run mode.
> 
> I will have to defer to the experts in this matter whether this is
> actually a bug in the mmc utility or just a less than clear definition
> in the standard or something else entirely.
> 
> --
> 
> i.A. Harald Brinkmann
> 
> BST eltromat International GmbH
> Werk Leopoldshöhe
> Herforder Straße 249-251
> D-33818 Leopoldshöhe
> 
> T:      +49 (5208) 987-513
> 
> E:      harald.brinkmann@bst-international.com
> W:      http://www.bst-eltromat.com
> 
> 
> 
> 
> _______________________________________________________
> Amtsgericht Bielefeld, HRB Nr. 30830
> Geschäftsführer Kristian Jünke, Dr. Johann-Carsten Kipp, Dr. Gunter
> Tautorus
> Sitz der Gesellschaft: Bielefeld
> Vertrauliche E-Mail von BST eltromat International GmbH
> 
> ��칻�&�~�&���+-��ݶ��w��˛���m�b��f�ȧ���ܨ}���Ơz�&j:+v�������zZ+��+zf���h���~����i���z��w���?����&�)ߢf
> 
