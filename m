Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB25145A0A
	for <linux-mmc@vger.kernel.org>; Wed,  7 Aug 2024 20:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723061789; cv=none; b=iIDciCxbED5oNByNU7NpOzpv09Q1udXZXRbUAROiA6x/YtEkNuAKe4QIqzNdZbErA4LyonY0gJZ+aosPG3prL/aAgGeeQSwytomcoxqaclp6PWpCe9qCGCyeFTQyukQI5EPWocczaYXAU1td5iFw32GYCssjDxCwtLoyHDce2d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723061789; c=relaxed/simple;
	bh=H5VDu2o6jkMqC8bMmfSAK52n6sJaTnd+yw2Q2ihT0+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h+MUs5FrKlt5MV87SbMgzfdkr6MQkNuRvmFtqaDkpRw4gBVITdxMYLMz4uqldD/3boWPbuScSd1DzbteC5PIrBTtYI+tmpLxKupYsD7bscTPsbPzS17bc0o3tdgf/tW7q04xZTqaOEBKLq9+snEV2O9d9O3WTetrU80C0vTPiWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d8tjehTi; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d8tjehTi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723061787; x=1754597787;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=H5VDu2o6jkMqC8bMmfSAK52n6sJaTnd+yw2Q2ihT0+Y=;
  b=d8tjehTifnCzf0urHlBnvLx2p7qjOv2fkVF5keU/k3xw6jieNJp6+xWf
   U/LDQ9y1NmIfM2IaHos7w8vS6jL0AWqez1QfCPxNmEmY3wrvHv5FAzok2
   T7svhxufm2ZzobNjkxLetTkVuqonUKhFeZFKx4OkdUnXaY6zi5dJu2HSm
   y6ChNnYaM/NPtVnDRythL5np8IPDsiPB9qIzfHX3FYsYn+c6/RWzuF4TZ
   miB/PS8ewQ3axj+4fT78+2dszqGanvzwJ/ib/wEcuLHRG0QKHGbvB9zu5
   /GvYwdYkDwSQlp3Ix3ReiA1wayrGWDfXE0X7uUOmyrMa2b6haRgb1BRYT
   Q==;
X-CSE-ConnectionGUID: 2FNxoSnSTt+yqBj3BEX1hA==
X-CSE-MsgGUID: KGu3ZJlmT2WtPNiPVJbZWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="32563046"
X-IronPort-AV: E=Sophos;i="6.09,270,1716274800"; 
   d="scan'208";a="32563046"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 13:16:26 -0700
X-CSE-ConnectionGUID: 5c99IUoETdu3rLpw83coYQ==
X-CSE-MsgGUID: n3YfZpyRSyOdhJRyRP185Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,270,1716274800"; 
   d="scan'208";a="57195113"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 07 Aug 2024 13:16:25 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sbn53-0005gm-2M;
	Wed, 07 Aug 2024 20:16:21 +0000
Date: Thu, 8 Aug 2024 04:15:40 +0800
From: kernel test robot <lkp@intel.com>
To: Avri Altman <avri.altman@wdc.com>, Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Ricky WU <ricky_wu@realtek.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: Re: [PATCH v2 08/10] mmc: core: Allow mmc erase to carry large
 addresses
Message-ID: <202408080458.9guIB91o-lkp@intel.com>
References: <20240807060309.2403023-9-avri.altman@wdc.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240807060309.2403023-9-avri.altman@wdc.com>

Hi Avri,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.11-rc2 next-20240807]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Avri-Altman/mmc-sd-SDUC-Support-Recognition/20240807-140950
base:   linus/master
patch link:    https://lore.kernel.org/r/20240807060309.2403023-9-avri.altman%40wdc.com
patch subject: [PATCH v2 08/10] mmc: core: Allow mmc erase to carry large addresses
config: i386-randconfig-004-20240807 (https://download.01.org/0day-ci/archive/20240808/202408080458.9guIB91o-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240808/202408080458.9guIB91o-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408080458.9guIB91o-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/mmc/core/core.o: in function `mmc_do_erase':
>> drivers/mmc/core/core.c:1651: undefined reference to `__udivdi3'
>> ld: drivers/mmc/core/core.c:1652: undefined reference to `__udivdi3'
   ld: drivers/mmc/core/core.o: in function `mmc_erase':
>> drivers/mmc/core/core.c:1827: undefined reference to `__umoddi3'
   ld: drivers/mmc/core/core.o: in function `mmc_align_erase_size':
   drivers/mmc/core/core.c:1745: undefined reference to `__umoddi3'
   ld: drivers/mmc/core/core.o: in function `mmc_erase':
   drivers/mmc/core/core.c:1803: undefined reference to `__umoddi3'


vim +1651 drivers/mmc/core/core.c

dfe86cba7676d5 Adrian Hunter   2010-08-11  1618  
d3d1cbaa99327c Avri Altman     2024-08-07  1619  static int mmc_do_erase(struct mmc_card *card, sector_t from,
d3d1cbaa99327c Avri Altman     2024-08-07  1620  			sector_t to, unsigned int arg)
dfe86cba7676d5 Adrian Hunter   2010-08-11  1621  {
c7836d1593b87c Masahiro Yamada 2016-12-19  1622  	struct mmc_command cmd = {};
bb4eecf23be259 Baolin Wang     2016-07-25  1623  	unsigned int qty = 0, busy_timeout = 0;
e62f1e0b2384e2 Ulf Hansson     2021-05-04  1624  	bool use_r1b_resp;
dfe86cba7676d5 Adrian Hunter   2010-08-11  1625  	int err;
dfe86cba7676d5 Adrian Hunter   2010-08-11  1626  
8f11d1064e01e1 Adrian Hunter   2015-05-07  1627  	mmc_retune_hold(card->host);
8f11d1064e01e1 Adrian Hunter   2015-05-07  1628  
dfe86cba7676d5 Adrian Hunter   2010-08-11  1629  	/*
dfe86cba7676d5 Adrian Hunter   2010-08-11  1630  	 * qty is used to calculate the erase timeout which depends on how many
dfe86cba7676d5 Adrian Hunter   2010-08-11  1631  	 * erase groups (or allocation units in SD terminology) are affected.
dfe86cba7676d5 Adrian Hunter   2010-08-11  1632  	 * We count erasing part of an erase group as one erase group.
dfe86cba7676d5 Adrian Hunter   2010-08-11  1633  	 * For SD, the allocation units are always a power of 2.  For MMC, the
dfe86cba7676d5 Adrian Hunter   2010-08-11  1634  	 * erase group size is almost certainly also power of 2, but it does not
dfe86cba7676d5 Adrian Hunter   2010-08-11  1635  	 * seem to insist on that in the JEDEC standard, so we fall back to
dfe86cba7676d5 Adrian Hunter   2010-08-11  1636  	 * division in that case.  SD may not specify an allocation unit size,
dfe86cba7676d5 Adrian Hunter   2010-08-11  1637  	 * in which case the timeout is based on the number of write blocks.
dfe86cba7676d5 Adrian Hunter   2010-08-11  1638  	 *
dfe86cba7676d5 Adrian Hunter   2010-08-11  1639  	 * Note that the timeout for secure trim 2 will only be correct if the
dfe86cba7676d5 Adrian Hunter   2010-08-11  1640  	 * number of erase groups specified is the same as the total of all
dfe86cba7676d5 Adrian Hunter   2010-08-11  1641  	 * preceding secure trim 1 commands.  Since the power may have been
dfe86cba7676d5 Adrian Hunter   2010-08-11  1642  	 * lost since the secure trim 1 commands occurred, it is generally
dfe86cba7676d5 Adrian Hunter   2010-08-11  1643  	 * impossible to calculate the secure trim 2 timeout correctly.
dfe86cba7676d5 Adrian Hunter   2010-08-11  1644  	 */
dfe86cba7676d5 Adrian Hunter   2010-08-11  1645  	if (card->erase_shift)
dfe86cba7676d5 Adrian Hunter   2010-08-11  1646  		qty += ((to >> card->erase_shift) -
dfe86cba7676d5 Adrian Hunter   2010-08-11  1647  			(from >> card->erase_shift)) + 1;
dfe86cba7676d5 Adrian Hunter   2010-08-11  1648  	else if (mmc_card_sd(card))
dfe86cba7676d5 Adrian Hunter   2010-08-11  1649  		qty += to - from + 1;
dfe86cba7676d5 Adrian Hunter   2010-08-11  1650  	else
dfe86cba7676d5 Adrian Hunter   2010-08-11 @1651  		qty += ((to / card->erase_size) -
dfe86cba7676d5 Adrian Hunter   2010-08-11 @1652  			(from / card->erase_size)) + 1;
dfe86cba7676d5 Adrian Hunter   2010-08-11  1653  
dfe86cba7676d5 Adrian Hunter   2010-08-11  1654  	if (!mmc_card_blockaddr(card)) {
dfe86cba7676d5 Adrian Hunter   2010-08-11  1655  		from <<= 9;
dfe86cba7676d5 Adrian Hunter   2010-08-11  1656  		to <<= 9;
dfe86cba7676d5 Adrian Hunter   2010-08-11  1657  	}
dfe86cba7676d5 Adrian Hunter   2010-08-11  1658  
dfe86cba7676d5 Adrian Hunter   2010-08-11  1659  	if (mmc_card_sd(card))
dfe86cba7676d5 Adrian Hunter   2010-08-11  1660  		cmd.opcode = SD_ERASE_WR_BLK_START;
dfe86cba7676d5 Adrian Hunter   2010-08-11  1661  	else
dfe86cba7676d5 Adrian Hunter   2010-08-11  1662  		cmd.opcode = MMC_ERASE_GROUP_START;
dfe86cba7676d5 Adrian Hunter   2010-08-11  1663  	cmd.arg = from;
dfe86cba7676d5 Adrian Hunter   2010-08-11  1664  	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
dfe86cba7676d5 Adrian Hunter   2010-08-11  1665  	err = mmc_wait_for_cmd(card->host, &cmd, 0);
dfe86cba7676d5 Adrian Hunter   2010-08-11  1666  	if (err) {
a3c76eb9d4a1e6 Girish K S      2011-10-11  1667  		pr_err("mmc_erase: group start error %d, "
dfe86cba7676d5 Adrian Hunter   2010-08-11  1668  		       "status %#x\n", err, cmd.resp[0]);
67716327eec7e9 Adrian Hunter   2011-08-29  1669  		err = -EIO;
dfe86cba7676d5 Adrian Hunter   2010-08-11  1670  		goto out;
dfe86cba7676d5 Adrian Hunter   2010-08-11  1671  	}
dfe86cba7676d5 Adrian Hunter   2010-08-11  1672  
dfe86cba7676d5 Adrian Hunter   2010-08-11  1673  	memset(&cmd, 0, sizeof(struct mmc_command));
dfe86cba7676d5 Adrian Hunter   2010-08-11  1674  	if (mmc_card_sd(card))
dfe86cba7676d5 Adrian Hunter   2010-08-11  1675  		cmd.opcode = SD_ERASE_WR_BLK_END;
dfe86cba7676d5 Adrian Hunter   2010-08-11  1676  	else
dfe86cba7676d5 Adrian Hunter   2010-08-11  1677  		cmd.opcode = MMC_ERASE_GROUP_END;
dfe86cba7676d5 Adrian Hunter   2010-08-11  1678  	cmd.arg = to;
dfe86cba7676d5 Adrian Hunter   2010-08-11  1679  	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
dfe86cba7676d5 Adrian Hunter   2010-08-11  1680  	err = mmc_wait_for_cmd(card->host, &cmd, 0);
dfe86cba7676d5 Adrian Hunter   2010-08-11  1681  	if (err) {
a3c76eb9d4a1e6 Girish K S      2011-10-11  1682  		pr_err("mmc_erase: group end error %d, status %#x\n",
dfe86cba7676d5 Adrian Hunter   2010-08-11  1683  		       err, cmd.resp[0]);
67716327eec7e9 Adrian Hunter   2011-08-29  1684  		err = -EIO;
dfe86cba7676d5 Adrian Hunter   2010-08-11  1685  		goto out;
dfe86cba7676d5 Adrian Hunter   2010-08-11  1686  	}
dfe86cba7676d5 Adrian Hunter   2010-08-11  1687  
dfe86cba7676d5 Adrian Hunter   2010-08-11  1688  	memset(&cmd, 0, sizeof(struct mmc_command));
dfe86cba7676d5 Adrian Hunter   2010-08-11  1689  	cmd.opcode = MMC_ERASE;
dfe86cba7676d5 Adrian Hunter   2010-08-11  1690  	cmd.arg = arg;
bb4eecf23be259 Baolin Wang     2016-07-25  1691  	busy_timeout = mmc_erase_timeout(card, arg, qty);
e62f1e0b2384e2 Ulf Hansson     2021-05-04  1692  	use_r1b_resp = mmc_prepare_busy_cmd(card->host, &cmd, busy_timeout);
bb4eecf23be259 Baolin Wang     2016-07-25  1693  
dfe86cba7676d5 Adrian Hunter   2010-08-11  1694  	err = mmc_wait_for_cmd(card->host, &cmd, 0);
dfe86cba7676d5 Adrian Hunter   2010-08-11  1695  	if (err) {
a3c76eb9d4a1e6 Girish K S      2011-10-11  1696  		pr_err("mmc_erase: erase error %d, status %#x\n",
dfe86cba7676d5 Adrian Hunter   2010-08-11  1697  		       err, cmd.resp[0]);
dfe86cba7676d5 Adrian Hunter   2010-08-11  1698  		err = -EIO;
dfe86cba7676d5 Adrian Hunter   2010-08-11  1699  		goto out;
dfe86cba7676d5 Adrian Hunter   2010-08-11  1700  	}
dfe86cba7676d5 Adrian Hunter   2010-08-11  1701  
dfe86cba7676d5 Adrian Hunter   2010-08-11  1702  	if (mmc_host_is_spi(card->host))
dfe86cba7676d5 Adrian Hunter   2010-08-11  1703  		goto out;
dfe86cba7676d5 Adrian Hunter   2010-08-11  1704  
bb4eecf23be259 Baolin Wang     2016-07-25  1705  	/*
bb4eecf23be259 Baolin Wang     2016-07-25  1706  	 * In case of when R1B + MMC_CAP_WAIT_WHILE_BUSY is used, the polling
bb4eecf23be259 Baolin Wang     2016-07-25  1707  	 * shall be avoided.
bb4eecf23be259 Baolin Wang     2016-07-25  1708  	 */
bb4eecf23be259 Baolin Wang     2016-07-25  1709  	if ((card->host->caps & MMC_CAP_WAIT_WHILE_BUSY) && use_r1b_resp)
bb4eecf23be259 Baolin Wang     2016-07-25  1710  		goto out;
bb4eecf23be259 Baolin Wang     2016-07-25  1711  
0d84c3e6a5b2cd Ulf Hansson     2020-02-04  1712  	/* Let's poll to find out when the erase operation completes. */
04f967ad28c836 Ulf Hansson     2021-05-04  1713  	err = mmc_poll_for_busy(card, busy_timeout, false, MMC_BUSY_ERASE);
8fee476b219d18 Trey Ramsay     2012-11-16  1714  
dfe86cba7676d5 Adrian Hunter   2010-08-11  1715  out:
8f11d1064e01e1 Adrian Hunter   2015-05-07  1716  	mmc_retune_release(card->host);
dfe86cba7676d5 Adrian Hunter   2010-08-11  1717  	return err;
dfe86cba7676d5 Adrian Hunter   2010-08-11  1718  }
dfe86cba7676d5 Adrian Hunter   2010-08-11  1719  
71085123d27dc5 Baolin Wang     2016-09-07  1720  static unsigned int mmc_align_erase_size(struct mmc_card *card,
d3d1cbaa99327c Avri Altman     2024-08-07  1721  					 sector_t *from,
d3d1cbaa99327c Avri Altman     2024-08-07  1722  					 sector_t *to,
71085123d27dc5 Baolin Wang     2016-09-07  1723  					 unsigned int nr)
71085123d27dc5 Baolin Wang     2016-09-07  1724  {
d3d1cbaa99327c Avri Altman     2024-08-07  1725  	sector_t from_new = *from;
d3d1cbaa99327c Avri Altman     2024-08-07  1726  	unsigned int nr_new = nr, rem;
71085123d27dc5 Baolin Wang     2016-09-07  1727  
6c689886fbe41b Baolin Wang     2016-09-07  1728  	/*
6c689886fbe41b Baolin Wang     2016-09-07  1729  	 * When the 'card->erase_size' is power of 2, we can use round_up/down()
6c689886fbe41b Baolin Wang     2016-09-07  1730  	 * to align the erase size efficiently.
6c689886fbe41b Baolin Wang     2016-09-07  1731  	 */
6c689886fbe41b Baolin Wang     2016-09-07  1732  	if (is_power_of_2(card->erase_size)) {
d3d1cbaa99327c Avri Altman     2024-08-07  1733  		sector_t temp = from_new;
6c689886fbe41b Baolin Wang     2016-09-07  1734  
6c689886fbe41b Baolin Wang     2016-09-07  1735  		from_new = round_up(temp, card->erase_size);
6c689886fbe41b Baolin Wang     2016-09-07  1736  		rem = from_new - temp;
6c689886fbe41b Baolin Wang     2016-09-07  1737  
6c689886fbe41b Baolin Wang     2016-09-07  1738  		if (nr_new > rem)
6c689886fbe41b Baolin Wang     2016-09-07  1739  			nr_new -= rem;
6c689886fbe41b Baolin Wang     2016-09-07  1740  		else
6c689886fbe41b Baolin Wang     2016-09-07  1741  			return 0;
6c689886fbe41b Baolin Wang     2016-09-07  1742  
6c689886fbe41b Baolin Wang     2016-09-07  1743  		nr_new = round_down(nr_new, card->erase_size);
6c689886fbe41b Baolin Wang     2016-09-07  1744  	} else {
71085123d27dc5 Baolin Wang     2016-09-07  1745  		rem = from_new % card->erase_size;
71085123d27dc5 Baolin Wang     2016-09-07  1746  		if (rem) {
71085123d27dc5 Baolin Wang     2016-09-07  1747  			rem = card->erase_size - rem;
71085123d27dc5 Baolin Wang     2016-09-07  1748  			from_new += rem;
71085123d27dc5 Baolin Wang     2016-09-07  1749  			if (nr_new > rem)
71085123d27dc5 Baolin Wang     2016-09-07  1750  				nr_new -= rem;
71085123d27dc5 Baolin Wang     2016-09-07  1751  			else
71085123d27dc5 Baolin Wang     2016-09-07  1752  				return 0;
71085123d27dc5 Baolin Wang     2016-09-07  1753  		}
71085123d27dc5 Baolin Wang     2016-09-07  1754  
71085123d27dc5 Baolin Wang     2016-09-07  1755  		rem = nr_new % card->erase_size;
71085123d27dc5 Baolin Wang     2016-09-07  1756  		if (rem)
71085123d27dc5 Baolin Wang     2016-09-07  1757  			nr_new -= rem;
6c689886fbe41b Baolin Wang     2016-09-07  1758  	}
71085123d27dc5 Baolin Wang     2016-09-07  1759  
71085123d27dc5 Baolin Wang     2016-09-07  1760  	if (nr_new == 0)
71085123d27dc5 Baolin Wang     2016-09-07  1761  		return 0;
71085123d27dc5 Baolin Wang     2016-09-07  1762  
71085123d27dc5 Baolin Wang     2016-09-07  1763  	*to = from_new + nr_new;
71085123d27dc5 Baolin Wang     2016-09-07  1764  	*from = from_new;
71085123d27dc5 Baolin Wang     2016-09-07  1765  
71085123d27dc5 Baolin Wang     2016-09-07  1766  	return nr_new;
71085123d27dc5 Baolin Wang     2016-09-07  1767  }
71085123d27dc5 Baolin Wang     2016-09-07  1768  
dfe86cba7676d5 Adrian Hunter   2010-08-11  1769  /**
dfe86cba7676d5 Adrian Hunter   2010-08-11  1770   * mmc_erase - erase sectors.
dfe86cba7676d5 Adrian Hunter   2010-08-11  1771   * @card: card to erase
dfe86cba7676d5 Adrian Hunter   2010-08-11  1772   * @from: first sector to erase
dfe86cba7676d5 Adrian Hunter   2010-08-11  1773   * @nr: number of sectors to erase
bc47e2f6f9e261 Avri Altman     2019-02-26  1774   * @arg: erase command argument
dfe86cba7676d5 Adrian Hunter   2010-08-11  1775   *
dfe86cba7676d5 Adrian Hunter   2010-08-11  1776   * Caller must claim host before calling this function.
dfe86cba7676d5 Adrian Hunter   2010-08-11  1777   */
d3d1cbaa99327c Avri Altman     2024-08-07  1778  int mmc_erase(struct mmc_card *card, sector_t from, unsigned int nr,
dfe86cba7676d5 Adrian Hunter   2010-08-11  1779  	      unsigned int arg)
dfe86cba7676d5 Adrian Hunter   2010-08-11  1780  {
d3d1cbaa99327c Avri Altman     2024-08-07  1781  	unsigned int rem;
d3d1cbaa99327c Avri Altman     2024-08-07  1782  	sector_t to = from + nr;
642c28ab86f766 David Jander    2015-06-23  1783  	int err;
dfe86cba7676d5 Adrian Hunter   2010-08-11  1784  
94fe2580a2f3bb Ulf Hansson     2020-05-08  1785  	if (!(card->csd.cmdclass & CCC_ERASE))
dfe86cba7676d5 Adrian Hunter   2010-08-11  1786  		return -EOPNOTSUPP;
dfe86cba7676d5 Adrian Hunter   2010-08-11  1787  
dfe86cba7676d5 Adrian Hunter   2010-08-11  1788  	if (!card->erase_size)
dfe86cba7676d5 Adrian Hunter   2010-08-11  1789  		return -EOPNOTSUPP;
dfe86cba7676d5 Adrian Hunter   2010-08-11  1790  
bc47e2f6f9e261 Avri Altman     2019-02-26  1791  	if (mmc_card_sd(card) && arg != SD_ERASE_ARG && arg != SD_DISCARD_ARG)
dfe86cba7676d5 Adrian Hunter   2010-08-11  1792  		return -EOPNOTSUPP;
dfe86cba7676d5 Adrian Hunter   2010-08-11  1793  
bc47e2f6f9e261 Avri Altman     2019-02-26  1794  	if (mmc_card_mmc(card) && (arg & MMC_SECURE_ARGS) &&
dfe86cba7676d5 Adrian Hunter   2010-08-11  1795  	    !(card->ext_csd.sec_feature_support & EXT_CSD_SEC_ER_EN))
dfe86cba7676d5 Adrian Hunter   2010-08-11  1796  		return -EOPNOTSUPP;
dfe86cba7676d5 Adrian Hunter   2010-08-11  1797  
489d144563f239 Christian Löhle 2022-11-17  1798  	if (mmc_card_mmc(card) && is_trim_arg(arg) &&
dfe86cba7676d5 Adrian Hunter   2010-08-11  1799  	    !(card->ext_csd.sec_feature_support & EXT_CSD_SEC_GB_CL_EN))
dfe86cba7676d5 Adrian Hunter   2010-08-11  1800  		return -EOPNOTSUPP;
dfe86cba7676d5 Adrian Hunter   2010-08-11  1801  
dfe86cba7676d5 Adrian Hunter   2010-08-11  1802  	if (arg == MMC_SECURE_ERASE_ARG) {
dfe86cba7676d5 Adrian Hunter   2010-08-11  1803  		if (from % card->erase_size || nr % card->erase_size)
dfe86cba7676d5 Adrian Hunter   2010-08-11  1804  			return -EINVAL;
dfe86cba7676d5 Adrian Hunter   2010-08-11  1805  	}
dfe86cba7676d5 Adrian Hunter   2010-08-11  1806  
71085123d27dc5 Baolin Wang     2016-09-07  1807  	if (arg == MMC_ERASE_ARG)
71085123d27dc5 Baolin Wang     2016-09-07  1808  		nr = mmc_align_erase_size(card, &from, &to, nr);
dfe86cba7676d5 Adrian Hunter   2010-08-11  1809  
dfe86cba7676d5 Adrian Hunter   2010-08-11  1810  	if (nr == 0)
dfe86cba7676d5 Adrian Hunter   2010-08-11  1811  		return 0;
dfe86cba7676d5 Adrian Hunter   2010-08-11  1812  
dfe86cba7676d5 Adrian Hunter   2010-08-11  1813  	if (to <= from)
dfe86cba7676d5 Adrian Hunter   2010-08-11  1814  		return -EINVAL;
dfe86cba7676d5 Adrian Hunter   2010-08-11  1815  
dfe86cba7676d5 Adrian Hunter   2010-08-11  1816  	/* 'from' and 'to' are inclusive */
dfe86cba7676d5 Adrian Hunter   2010-08-11  1817  	to -= 1;
dfe86cba7676d5 Adrian Hunter   2010-08-11  1818  
642c28ab86f766 David Jander    2015-06-23  1819  	/*
642c28ab86f766 David Jander    2015-06-23  1820  	 * Special case where only one erase-group fits in the timeout budget:
642c28ab86f766 David Jander    2015-06-23  1821  	 * If the region crosses an erase-group boundary on this particular
642c28ab86f766 David Jander    2015-06-23  1822  	 * case, we will be trimming more than one erase-group which, does not
642c28ab86f766 David Jander    2015-06-23  1823  	 * fit in the timeout budget of the controller, so we need to split it
642c28ab86f766 David Jander    2015-06-23  1824  	 * and call mmc_do_erase() twice if necessary. This special case is
642c28ab86f766 David Jander    2015-06-23  1825  	 * identified by the card->eg_boundary flag.
642c28ab86f766 David Jander    2015-06-23  1826  	 */
642c28ab86f766 David Jander    2015-06-23 @1827  	rem = card->erase_size - (from % card->erase_size);
489d144563f239 Christian Löhle 2022-11-17  1828  	if ((arg & MMC_TRIM_OR_DISCARD_ARGS) && card->eg_boundary && nr > rem) {
642c28ab86f766 David Jander    2015-06-23  1829  		err = mmc_do_erase(card, from, from + rem - 1, arg);
642c28ab86f766 David Jander    2015-06-23  1830  		from += rem;
642c28ab86f766 David Jander    2015-06-23  1831  		if ((err) || (to <= from))
642c28ab86f766 David Jander    2015-06-23  1832  			return err;
642c28ab86f766 David Jander    2015-06-23  1833  	}
642c28ab86f766 David Jander    2015-06-23  1834  
dfe86cba7676d5 Adrian Hunter   2010-08-11  1835  	return mmc_do_erase(card, from, to, arg);
dfe86cba7676d5 Adrian Hunter   2010-08-11  1836  }
dfe86cba7676d5 Adrian Hunter   2010-08-11  1837  EXPORT_SYMBOL(mmc_erase);
dfe86cba7676d5 Adrian Hunter   2010-08-11  1838  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
