From: Qiang Gao <gaoqiangscut@gmail.com>
Subject: Re: process hangs on do_exit when oom happens
Date: Tue, 23 Oct 2012 17:08:40 +0800
Message-ID: <CAKWKT+ZG-Rw5spLUdn74H3QQ1RGrax2B4X_ksZB-OCHY5WXC6w@mail.gmail.com>
References: <op.wmbi5kbrn27o5l@gaoqiang-d1.corp.qihoo.net>
	<20121019160425.GA10175@dhcp22.suse.cz>
	<CAKWKT+ZRMHzgCLJ1quGnw-_T1b9OboYKnQdRc2_Z=rdU_PFVtw@mail.gmail.com>
	<20121023083556.GB15397@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:43705 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756666Ab2JWJIm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 23 Oct 2012 05:08:42 -0400
In-Reply-To: <20121023083556.GB15397@dhcp22.suse.cz>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Michal Hocko <mhocko@suse.cz>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, linux-mm@kvack.org, bsingharora@gmail.com

this is just an example to show how to reproduce. actually,the first time I saw
this situation was on a machine with 288G RAM with many tasks running and
we limit 30G for each.  but finanlly, no one exceeds this limit the the system
oom.


On Tue, Oct 23, 2012 at 4:35 PM, Michal Hocko <mhocko@suse.cz> wrote:
> On Tue 23-10-12 11:35:52, Qiang Gao wrote:
>> I'm sure this is a global-oom,not cgroup-oom. [the dmesg output in the end]
>
> Yes this is the global oom killer because:
>> cglimit -M 700M ./tt
>> then after global-oom,the process hangs..
>
>> 179184 pages RAM
>
> So you have ~700M of RAM so the memcg limit is basically pointless as it
> cannot be reached...
> --
> Michal Hocko
> SUSE Labs
