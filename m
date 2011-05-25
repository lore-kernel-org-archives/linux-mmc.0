From: "Robert P. J. Day" <rpjday@crashcourse.ca>
Subject: how to unbind current mmc driver to bind mmc-test driver?
Date: Wed, 25 May 2011 13:58:13 -0400 (EDT)
Message-ID: <alpine.DEB.2.00.1105251346490.12045@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811583-1405480937-1306346299=:12045"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from astoria.ccjclearline.com ([64.235.106.9]:38956 "EHLO
	astoria.ccjclearline.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750966Ab1EYR6U (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 25 May 2011 13:58:20 -0400
Received: from cpec03f0ed08c7f-cm001ac318e826.cpe.net.cable.rogers.com ([99.241.2.77] helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <rpjday@crashcourse.ca>)
	id 1QPILb-0007a4-69
	for linux-mmc@vger.kernel.org; Wed, 25 May 2011 13:58:19 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811583-1405480937-1306346299=:12045
Content-Type: TEXT/PLAIN; charset=US-ASCII


  ever willing to embarrass myself in public, i'm going to ask how to
load and invoke the mmc_test driver on my ubuntu laptop, which is
currently running my hand-rolled super-recent, 2.6.39+ kernel.

  i'm following along in the script here:

http://www.spinics.net/lists/linux-mmc/msg05835.html

and it seems pretty straightforward -- i interpret all of that as that
one needs first to find the driver that is currently bound to the
device (mmc-block?), unbind it, then bind to the mmc test driver.
that seems easy enough except that this loop in the script:

...
cd "$drv_path"     [this is "/sys/bus/mmc/drivers"]
for d in *;do
    for l in "$d/"*;do
	[ -h "$l" ] || continue
	card="$(basename "$l")"
	driver="$(dirname "$l")"
	break
    done
    [ -n "$card" ] && break
done
...

is clearly looking for the *current* driver but, on my system, there
is none.  on this laptop, the MMC card slot appears to be managed by
the SCSI driver and USB storage, so there is no symlink there; hence,
the script fails in the next check:

...
if [ -z "$card" ];then
    echo "No MMC/SD card found"
    exit 1
fi
...

  the mmc-block driver is built as a module, but it's never loaded
upon insertion of a card.  so to try to track down what's happening, i
fired up "udevadm monitor --kernel" to watch the events upon insertion
of an SD card, and i attached the dozen lines of (abbreviated) output.

  at this point, i'm not sure what to do.  i can certainly load the
mmc_test module, at which point i will get under /sys/bus/mmc/drivers:

$ find
.
./uevent
./unbind
./bind
$

  the rest of the script requires one to perform the MMC tests by
writing to the appropriate entry under debugfs, which i have mounted
but i have no idea what to look for under there.

  thoughts?

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
---1463811583-1405480937-1306346299=:12045
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=udevadm
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.DEB.2.00.1105251358130.12045@localhost6.localdomain6>
Content-Description: 
Content-Disposition: attachment; filename=udevadm

L3BjaTAwMDA6MDAvMDAwMDowMDoxYS4wL3VzYjEvMS0xLzEtMS4xICh1c2Ip
DQovcGNpMDAwMDowMC8wMDAwOjAwOjFhLjAvdXNiMS8xLTEvMS0xLjEvMS0x
LjE6MS4wICh1c2IpDQovcGNpMDAwMDowMC8wMDAwOjAwOjFhLjAvdXNiMS8x
LTEvMS0xLjEvMS0xLjE6MS4wL2hvc3QxNSAoc2NzaSkNCi9wY2kwMDAwOjAw
LzAwMDA6MDA6MWEuMC91c2IxLzEtMS8xLTEuMS8xLTEuMToxLjAvaG9zdDE1
L3Njc2lfaG9zdC9ob3N0MTUgKHNjc2lfaG9zdCkNCi9wY2kwMDAwOjAwLzAw
MDA6MDA6MWEuMC91c2IxLzEtMS8xLTEuMS8xLTEuMToxLjAvaG9zdDE1L3Rh
cmdldDE1OjA6MCAoc2NzaSkNCi9wY2kwMDAwOjAwLzAwMDA6MDA6MWEuMC91
c2IxLzEtMS8xLTEuMS8xLTEuMToxLjAvaG9zdDE1L3RhcmdldDE1OjA6MC8x
NTowOjA6MCAoc2NzaSkNCi9wY2kwMDAwOjAwLzAwMDA6MDA6MWEuMC91c2Ix
LzEtMS8xLTEuMS8xLTEuMToxLjAvaG9zdDE1L3RhcmdldDE1OjA6MC8xNTow
OjA6MC9zY3NpX2Rpc2svMTU6MDowOjAgKHNjc2lfZGlzaykNCi9wY2kwMDAw
OjAwLzAwMDA6MDA6MWEuMC91c2IxLzEtMS8xLTEuMS8xLTEuMToxLjAvaG9z
dDE1L3RhcmdldDE1OjA6MC8xNTowOjA6MC9zY3NpX2RldmljZS8xNTowOjA6
MCAoc2NzaV9kZXZpY2UpDQovcGNpMDAwMDowMC8wMDAwOjAwOjFhLjAvdXNi
MS8xLTEvMS0xLjEvMS0xLjE6MS4wL2hvc3QxNS90YXJnZXQxNTowOjAvMTU6
MDowOjAvc2NzaV9nZW5lcmljL3NnMiAoc2NzaV9nZW5lcmljKQ0KL3BjaTAw
MDA6MDAvMDAwMDowMDoxYS4wL3VzYjEvMS0xLzEtMS4xLzEtMS4xOjEuMC9o
b3N0MTUvdGFyZ2V0MTU6MDowLzE1OjA6MDowL2JzZy8xNTowOjA6MCAoYnNn
KQ0KL3ZpcnR1YWwvYmRpLzg6MTYgKGJkaSkNCi9wY2kwMDAwOjAwLzAwMDA6
MDA6MWEuMC91c2IxLzEtMS8xLTEuMS8xLTEuMToxLjAvaG9zdDE1L3Rhcmdl
dDE1OjA6MC8xNTowOjA6MC9ibG9jay9zZGIgKGJsb2NrKQ0KL3BjaTAwMDA6
MDAvMDAwMDowMDoxYS4wL3VzYjEvMS0xLzEtMS4xLzEtMS4xOjEuMC9ob3N0
MTUvdGFyZ2V0MTU6MDowLzE1OjA6MDowL2Jsb2NrL3NkYi9zZGIxIChibG9j
aykNCi9wY2kwMDAwOjAwLzAwMDA6MDA6MWEuMC91c2IxLzEtMS8xLTEuMS8x
LTEuMToxLjAvaG9zdDE1L3RhcmdldDE1OjA6MC8xNTowOjA6MC9ibG9jay9z
ZGIvc2RiMiAoYmxvY2spDQovcGNpMDAwMDowMC8wMDAwOjAwOjFhLjAvdXNi
MS8xLTEvMS0xLjEvMS0xLjE6MS4wL2hvc3QxNS90YXJnZXQxNTowOjAvMTU6
MDowOjAvYmxvY2svc2RiL3NkYjMgKGJsb2NrKQ0K

---1463811583-1405480937-1306346299=:12045--
